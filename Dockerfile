# syntax=docker/dockerfile:1@sha256:4edf897a3ffa55b89f906fc8cc78afdb3f1834cc9c7083565e611a8a7d5fe99e
# The official Seafile image, installable from one Unraid template. The stock
# scripts still run Seafile; rootfs/ adds generated secrets and, on request,
# MariaDB, Redis and the notification server in the same container. /shared keeps
# the stock layout, so existing setups can switch to this image.

FROM seafileltd/notification-server:14.0.8-testing@sha256:bc6fe81de7c1af2dc08c184f2a3d558e21eca493c5362a2fc725e20a88fbb280 AS notification

FROM seafileltd/seafile-mc:14.0.8-testing@sha256:a0b5e08392df7ad1958bf15d33344823f2eabaeedabb022458f499b5154ad4ed

LABEL org.opencontainers.image.title="seafile (Unraid)" \
      org.opencontainers.image.description="Seafile for Unraid in one container: generated secrets, optional built-in MariaDB, Redis and notification server." \
      org.opencontainers.image.source="https://github.com/junkerderprovinz/seafile" \
      org.opencontainers.image.licenses="AGPL-3.0-only" \
      org.opencontainers.image.vendor="junkerderprovinz"

# Ubuntu tracks security fixes inside the 10.11 and 7.0 series, so the versions
# are left to the archive.
# hadolint ignore=DL3008
RUN apt-get update \
 && apt-get install -y --no-install-recommends mariadb-server redis-server \
 && rm -rf /var/lib/apt/lists/* /var/lib/mysql/*

COPY --from=notification /opt/seafile/notification-server /opt/seafile/notification-server
COPY rootfs/ /
COPY print-banner.sh /usr/local/bin/
COPY .github/assets/banner-raw.txt /usr/local/share/banner-raw.txt

# The extra locations go in through an include, so the stock server block stays
# as upstream ships it. The grep stops the build if upstream renames the file or
# moves its first location.
RUN sed -i 's|^    location / {|    include /etc/nginx/seafile.d/*.conf;\n\n&|' /etc/nginx/sites-enabled/seafile.nginx.conf \
 && grep -q 'include /etc/nginx/seafile.d/\*.conf;' /etc/nginx/sites-enabled/seafile.nginx.conf \
 && tr -d '\r' < /usr/local/share/banner-raw.txt > /usr/local/share/banner.txt \
 && rm /usr/local/share/banner-raw.txt \
 && mkdir -p /etc/nginx/seafile.d \
 && chmod +x /etc/my_init.d/00_prepare.sh /etc/my_init.pre_shutdown.d/10_stop_seafile.sh /etc/sv/*/run /usr/local/bin/print-banner.sh /opt/seafile/notification-server

# Seahub imports seahub/local_settings.py if it exists, and that is where the web
# office from the template goes in. The grep stops the build if upstream drops
# the import.
RUN seahub="/opt/seafile/seafile-server-${SEAFILE_VERSION}/seahub/seahub" \
 && grep -q '^    import seahub.local_settings$' "$seahub/settings.py" \
 && mv /usr/local/share/seafile/local_settings.py "$seahub/"

# The stock setup has no fallback for the database names and quits without them.
# Seafile's own logs go to the container log, which is where Unraid users look
# first.
ENV SEAFILE_MYSQL_DB_USER=seafile \
    SEAFILE_MYSQL_DB_CCNET_DB_NAME=ccnet_db \
    SEAFILE_MYSQL_DB_SEAFILE_DB_NAME=seafile_db \
    SEAFILE_MYSQL_DB_SEAHUB_DB_NAME=seahub_db \
    SEAFILE_SERVER_PROTOCOL=http \
    SEAFILE_LOG_TO_STDOUT=true

HEALTHCHECK --interval=30s --timeout=10s --start-period=300s --retries=3 \
    CMD ["curl", "-fsS", "-o", "/dev/null", "http://127.0.0.1/api2/ping/"]
