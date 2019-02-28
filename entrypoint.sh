#!/usr/bin/env bash

set -exo pipefail

if [ "$1" == 'java' ]; then
  exec chown -R "${MC_USER}":"${MC_USER}" /opt; java -jar -Xms"${JAVA_MAX_MEM}" -Xmx"${JAVA_MAX_MEM}"  /opt/forge-"${MC_VERSION}"-"${FORGE_VERSION}"-universal.jar nogui
fi

exec "$@"