FROM alpine:3.9

#-------------------------------------------------------------------------------
#  Environment Variables
#-------------------------------------------------------------------------------
ENV JAVA_MIN_MEM        1G
ENV JAVA_MAX_MEM        2G
ENV MC_USER             minecraft
ENV MC_USER_ID          1000
ENV MC_VERSION          1.12.2
ENV FORGE_VERSION       14.23.5.2814

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

RUN cd /opt && wget https://files.minecraftforge.net/maven/net/minecraftforge/forge/"${MC_VERSION}"-"${FORGE_VERSION}"/forge-"${MC_VERSION}"-"${FORGE_VERSION}"-installer.jar \
    && java -jar forge-"${MC_VERSION}"-"${FORGE_VERSION}"-installer.jar --installServer \
    && echo "eula=true" > eula.txt \
    && mkdir /opt/data /opt/mods

COPY server.properties /opt/server.properties

#-------------------------------------------------------------------------------
#  Download Minecraft mods
#-------------------------------------------------------------------------------
RUN cd /opt/mods \
    && wget https://media.forgecdn.net/files/2653/725/ClaySoldiersMod-1.12.2-3.0.0-beta.2.jar \
    && wget https://media.forgecdn.net/files/2653/971/SanLib-1.12.2-1.5.1.jar

VOLUME ["/opt/data", "/opt/config"]

RUN chown -R "${MC_USER}":"${MC_USER}" /opt 
WORKDIR /opt

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

USER ${MC_USER}
CMD java -jar -Xms"${JAVA_MAX_MEM}" -Xmx"${JAVA_MAX_MEM}"  forge-"${MC_VERSION}"-"${FORGE_VERSION}"-universal.jar nogui