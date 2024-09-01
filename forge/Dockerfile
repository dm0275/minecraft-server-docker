FROM ubuntu:22.04

#-------------------------------------------------------------------------------
#  Build Args
#-------------------------------------------------------------------------------
ARG mc_version
ARG forge_version
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
    MC_VERSION=${mc_version} \
    FORGE_VERSION=${forge_version} \
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
#  Download and configure Minecraft/Forge
#-------------------------------------------------------------------------------
RUN apt update \
    && apt install -y wget openjdk-${java_version}-jdk

RUN mkdir ${MINECRAFT_HOME} \
    && cd ${MINECRAFT_HOME} && wget https://files.minecraftforge.net/maven/net/minecraftforge/forge/"${MC_VERSION}"-"${FORGE_VERSION}"/forge-"${MC_VERSION}"-"${FORGE_VERSION}"-installer.jar \
    && java -jar forge-"${MC_VERSION}"-"${FORGE_VERSION}"-installer.jar --installServer \
    && echo "eula=true" > eula.txt \
    && mkdir -p ${MINECRAFT_HOME}/data ${MINECRAFT_HOME}/mods ${MINECRAFT_HOME}/world

COPY files/server.properties ${MINECRAFT_HOME}/server.properties
COPY files/start-minecraft.sh ${MINECRAFT_HOME}/

RUN chown -R "${MC_USER}":"${MC_USER}" ${MINECRAFT_HOME} 
WORKDIR ${MINECRAFT_HOME}

VOLUME ["${MINECRAFT_HOME}/data", "${MINECRAFT_HOME}/mods", "${MINECRAFT_HOME}/world"]

COPY files/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

USER ${MC_USER}
CMD ["/bin/bash", "start-minecraft.sh"]
