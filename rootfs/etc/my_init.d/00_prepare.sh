#!/bin/bash
# Runs before the stock startup scripts. my_init reloads /etc/container_environment
# after every startup script, so whatever set_env writes there reaches the stock
# scripts, Seafile itself and every runit service.
set -euo pipefail

print-banner.sh "Seafile" "${SEAFILE_VERSION}"

secrets=/shared/secrets.env
mkdir -p /shared
touch "$secrets"
chmod 600 "$secrets"

log() { echo "[prepare] $*"; }

fail() {
    log "$*"
    exit 1
}

enabled() {
    case "${1,,}" in
        true | yes | on | 1) return 0 ;;
        *) return 1 ;;
    esac
}

set_env() {
    printf '%s' "$2" > "/etc/container_environment/$1"
    export "$1=$2"
}

# Prints a generated value from the secrets file, creating it on first use.
secret() {
    local value
    value=$(sed -n "s/^$1=//p" "$secrets")
    if [ -z "$value" ]; then
        value=$(openssl rand -hex 24)
        printf '%s=%s\n' "$1" "$value" >> "$secrets"
    fi
    printf '%s' "$value"
}

# runit starts whatever is linked into /etc/service. The link is also removed when
# a switch is off, because Unraid restarts the same container after an edit.
service() {
    if [ "$2" = on ]; then
        ln -sfn "/etc/sv/$1" "/etc/service/$1"
    else
        rm -f "/etc/service/$1"
    fi
}

# Builds the database next to its final place and moves it there only once root
# has its password, so an interrupted first start leaves nothing half done.
init_mariadb() {
    local root_password=$1 datadir=/shared/mariadb.new tries=0
    rm -rf "$datadir"
    install -d -o mysql -g mysql "$datadir"
    mariadb-install-db --user=mysql --datadir="$datadir" --auth-root-authentication-method=normal --skip-test-db > /dev/null
    mariadbd --user=mysql --datadir="$datadir" --skip-networking > /dev/null 2>&1 &
    until mariadb-admin --protocol=socket ping --silent 2> /dev/null; do
        tries=$((tries + 1))
        [ "$tries" -lt 60 ] || fail "MariaDB did not come up for its first setup."
        sleep 1
    done
    # Seafile connects over TCP with skip-name-resolve on, so root keeps exactly
    # the accounts for the socket and for 127.0.0.1.
    mariadb --protocol=socket -uroot <<SQL
DELETE FROM mysql.global_priv WHERE Host NOT IN ('localhost', '127.0.0.1');
DELETE FROM mysql.proxies_priv WHERE Host NOT IN ('localhost', '127.0.0.1');
FLUSH PRIVILEGES;
CREATE USER IF NOT EXISTS 'root'@'127.0.0.1';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${root_password}';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY '${root_password}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION;
SQL
    mariadb-admin --protocol=socket -uroot -p"${root_password}" shutdown
    wait
    rm -rf /shared/mariadb
    mv "$datadir" /shared/mariadb
}

if [ -z "${SEAFILE_SERVER_HOSTNAME:-}" ]; then
    fail "SEAFILE_SERVER_HOSTNAME is empty. Set it to the address clients use, such as seafile.example.com or 192.168.1.10:8000."
fi
if ! enabled "${BUILTIN_MARIADB:-false}" && [ -z "${SEAFILE_MYSQL_DB_HOST:-}" ]; then
    fail "SEAFILE_MYSQL_DB_HOST is empty. Point it at your MariaDB or MySQL server, or set BUILTIN_MARIADB=true."
fi
if ! enabled "${BUILTIN_REDIS:-false}" && [ "${CACHE_PROVIDER:-redis}" = redis ] && [ -z "${REDIS_HOST:-}" ]; then
    fail "REDIS_HOST is empty. Point it at your Redis server, or set BUILTIN_REDIS=true."
fi

if [ -z "${TIME_ZONE:-}" ] && [ -n "${TZ:-}" ]; then
    set_env TIME_ZONE "$TZ"
fi

if [ -z "${JWT_PRIVATE_KEY:-}" ]; then
    set_env JWT_PRIVATE_KEY "$(secret JWT_PRIVATE_KEY)"
fi

# Left empty, the stock setup gives the database user a random password that
# Seafile never learns, so the first start would end in "Failed to load database
# config".
if [ -z "${SEAFILE_MYSQL_DB_PASSWORD:-}" ]; then
    set_env SEAFILE_MYSQL_DB_PASSWORD "$(secret SEAFILE_MYSQL_DB_PASSWORD)"
fi

if [ ! -d /shared/seafile/seafile-data ] && [ -z "${INIT_SEAFILE_ADMIN_PASSWORD:-}" ]; then
    set_env INIT_SEAFILE_ADMIN_PASSWORD "$(secret INIT_SEAFILE_ADMIN_PASSWORD)"
    log "No admin password was set. ${INIT_SEAFILE_ADMIN_EMAIL:-me@example.com} signs in with ${INIT_SEAFILE_ADMIN_PASSWORD}, which is also kept in ${secrets}."
fi

if enabled "${BUILTIN_MARIADB:-false}"; then
    set_env SEAFILE_MYSQL_DB_HOST 127.0.0.1
    set_env SEAFILE_MYSQL_DB_PORT 3306
    root_password=$(secret MARIADB_ROOT_PASSWORD)
    set_env INIT_SEAFILE_MYSQL_ROOT_PASSWORD "$root_password"
    install -d -o mysql -g mysql /run/mysqld
    if ! chpst -u mysql test -x /shared; then
        log "Letting the mysql user pass through /shared, which the built-in MariaDB needs."
        chmod o+x /shared
    fi
    if [ ! -d /shared/mariadb/mysql ]; then
        log "Creating the built-in MariaDB in /shared/mariadb."
        init_mariadb "$root_password"
    fi
    if [ "$(stat -c %U /shared/mariadb/mysql)" != mysql ]; then
        chown -R mysql:mysql /shared/mariadb
    fi
    service mariadb on
else
    service mariadb off
fi

if enabled "${BUILTIN_REDIS:-false}"; then
    set_env CACHE_PROVIDER redis
    set_env REDIS_HOST 127.0.0.1
    set_env REDIS_PORT 6379
    set_env REDIS_PASSWORD ""
    service redis on
else
    service redis off
fi

if enabled "${ENABLE_NOTIFICATION_SERVER:-false}"; then
    if [ -z "${NOTIFICATION_SERVER_URL:-}" ]; then
        set_env NOTIFICATION_SERVER_URL "${SEAFILE_SERVER_PROTOCOL:-http}://${SEAFILE_SERVER_HOSTNAME}/notification"
    fi
    # seaf-server has no default for this and otherwise never reports a change.
    if [ -z "${INNER_NOTIFICATION_SERVER_URL:-}" ]; then
        set_env INNER_NOTIFICATION_SERVER_URL http://127.0.0.1:8083
    fi
    cp /usr/local/share/seafile/notification.conf /etc/nginx/seafile.d/
    service notification-server on
else
    rm -f /etc/nginx/seafile.d/notification.conf
    service notification-server off
fi
