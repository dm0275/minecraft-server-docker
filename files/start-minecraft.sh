#!/bin/bash

set -euo pipefail

function run_minecraft {
    if [ "$MC_SERVER_TYPE" = "vanilla" ]; then
        ${JAVA_HOME}/bin/java -jar -Xms"${JAVA_MAX_MEM}" -Xmx"${JAVA_MAX_MEM}" ${MINECRAFT_HOME}/minecraft_server."${MC_VERSION}".jar
    elif [ "$MC_SERVER_TYPE" = "forge" ]; then
        if [ -f "${MINECRAFT_HOME}/run.sh" ]; then
            ${MINECRAFT_HOME}/run.sh
        else
            ${JAVA_HOME}/bin/java -jar -Xms"${JAVA_MAX_MEM}" -Xmx"${JAVA_MAX_MEM}" ${MINECRAFT_HOME}/forge-"${MC_VERSION}"-"${FORGE_VERSION}".jar
        fi
    elif [ "$MC_SERVER_TYPE" = "fabric" ]; then
        ${JAVA_HOME}/bin/java -jar -Xms"${JAVA_MAX_MEM}" -Xmx"${JAVA_MAX_MEM}" ${MINECRAFT_HOME}/fabric-server-mc-"${FABRIC_VERSION}".jar nogui
    else
        echo "Unknown Minecraft server type: $MC_SERVER_TYPE. Supported types are 'vanilla', 'forge', and 'fabric'."
    fi
}

if [ "${UID}" -eq 0 ]; then
    echo "User is currently root. Will change directory ownership to ${MC_USER}:${MC_USER}, then downgrade permission to ${MC_USER}"

    # Now drop privileges
    exec su -s /bin/bash "${MC_USER}" -c run_minecraft
else
    [[ -z ${JAVA_HOME} ]] && echo "Need to set JAVA_HOME environment variable" && exit -1;
    [[ ! -x ${JAVA_HOME}/bin/java ]] && echo "Cannot find an executable \
        JVM at path ${JAVA_HOME}/bin/java check your JAVA_HOME" && exit -1;
    run_minecraft
fi
