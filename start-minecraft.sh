#!/bin/bash

set -euo pipefail

export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

if [ "${UID}" -eq 0 ]; then
    echo "User is currently root. Will change directory ownership to ${MC_USER}:${MC_USER}, then downgrade permission to ${MC_USER}"

    # Now drop privileges
    exec su -s /bin/bash "${MC_USER}" -c "${JAVA_HOME}/bin/java -jar -Xms"${JAVA_MAX_MEM}" -Xmx"${JAVA_MAX_MEM}"  forge-"${MC_VERSION}"-"${FORGE_VERSION}"-universal.jar nogui"
else
    [[ -z ${JAVA_HOME} ]] && echo "Need to set JAVA_HOME environment variable" && exit -1;
    [[ ! -x ${JAVA_HOME}/bin/java ]] && echo "Cannot find an executable \
JVM at path ${JAVA_HOME}/bin/java check your JAVA_HOME" && exit -1;
    ${JAVA_HOME}/bin/java -jar -Xms"${JAVA_MAX_MEM}" -Xmx"${JAVA_MAX_MEM}"  ${MINECRAFT_HOME}/forge-"${MC_VERSION}"-"${FORGE_VERSION}"-universal.jar
fi