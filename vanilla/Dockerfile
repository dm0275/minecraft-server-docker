FROM alpine:3.9

#-------------------------------------------------------------------------------
#  Environment Variables
#-------------------------------------------------------------------------------
ARG mc_vanilla
ARG mc_version
ARG mc_url_link

ENV JAVA_MIN_MEM=1G \
    JAVA_MAX_MEM=2G \
    MC_USER=minecraft \
    MC_USER_ID=1000 \
    MC_VERSION=${mc_version} \
    MC_VANILLA=true \
    MC_URL_LINK=${mc_url_link} \
    MINECRAFT_HOME=/opt/minecraft \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

EXPOSE 25565

#-------------------------------------------------------------------------------
#  Add Minecraft user
#-------------------------------------------------------------------------------
RUN addgroup -g "$MC_USER_ID" "$MC_USER" \
    && adduser \
    -D -G "$MC_USER" \
    -u "$MC_USER_ID" \
    "$MC_USER"

#-------------------------------------------------------------------------------
#  Download and configure Minecraft/Forge
#-------------------------------------------------------------------------------
RUN apk update && apk upgrade \
    && apk add openjdk8 wget curl bash

RUN mkdir ${MINECRAFT_HOME} \
    && cd ${MINECRAFT_HOME} && wget "${MC_URL_LINK}" -O minecraft_server."${MC_VERSION}".jar \
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

