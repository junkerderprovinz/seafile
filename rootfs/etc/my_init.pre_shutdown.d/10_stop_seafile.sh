#!/bin/bash
# The stock entrypoint leaves Seafile running until my_init kills every process,
# by which time runit has already stopped the built-in MariaDB and Redis under it.
# Pre-shutdown scripts run before runit stops anything.
cd "/opt/seafile/seafile-server-${SEAFILE_VERSION}" || exit 0
./seahub.sh stop || true
./seafile.sh stop || true
