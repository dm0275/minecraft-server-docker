FROM ubuntu:22.04

#-------------------------------------------------------------------------------
#  Build Args
#-------------------------------------------------------------------------------
ARG mc_version
ARG fabric_version
ARG fabric_installer_version
ARG java_version
ARG TARGETOS
ARG TARGETARCH

#-------------------------------------------------------------------------------
#  Environment Variables
#-------------------------------------------------------------------------------
ENV JAVA_MIN_MEM=1G \
    JAVA_MAX_MEM=2G \
    MC_USER=minecraft \
    MC_USER_ID=1000 \
    MC_VANILLA=false \
    MC_SERVER_TYPE=fabric \
    MC_VERSION=${mc_version} \
    FABRIC_VERSION=${fabric_version} \
    FABRIC_INSTALLER_VERSION=${fabric_installer_version} \
    MINECRAFT_HOME=/opt/minecraft \
    JAVA_HOME=/usr/lib/jvm/java-${java_version}-openjdk-${TARGETARCH}

EXPOSE 25565

#-------------------------------------------------------------------------------
#  Add Minecraft user
#-------------------------------------------------------------------------------
RUN groupadd -g "$MC_USER_ID" "$MC_USER" \
    && useradd \
    -g "$MC_USER_ID" \
    -u "$MC_USER_ID" \
    "$MC_USER"

#-------------------------------------------------------------------------------
#  Download and configure Minecraft/Fabric
#-------------------------------------------------------------------------------
RUN apt update \
    && apt install -y wget openjdk-${java_version}-jdk

RUN mkdir ${MINECRAFT_HOME} \
    && cd ${MINECRAFT_HOME} && wget https://meta.fabricmc.net/v2/versions/loader/"${MC_VERSION}"/"${FABRIC_VERSION}"/"${FABRIC_INSTALLER_VERSION}"/server/jar -O  fabric-server-mc-"${FABRIC_VERSION}".jar  \
    && echo "eula=true" > eula.txt \
    && mkdir -p ${MINECRAFT_HOME}/data ${MINECRAFT_HOME}/mods ${MINECRAFT_HOME}/world

COPY files/server.properties.bk ${MINECRAFT_HOME}/server.properties.bk
COPY files/start-minecraft.sh ${MINECRAFT_HOME}/

RUN chown -R "${MC_USER}":"${MC_USER}" ${MINECRAFT_HOME} 
WORKDIR ${MINECRAFT_HOME}

VOLUME ["${MINECRAFT_HOME}/data", "${MINECRAFT_HOME}/mods", "${MINECRAFT_HOME}/world"]

COPY files/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

USER ${MC_USER}
CMD ["/bin/bash", "start-minecraft.sh"]
