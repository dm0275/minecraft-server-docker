FROM alpine:3.9

RUN apk update && apk upgrade \
    && apk add openjdk8 wget curl bash

# Mods are located in /opt/mods and we need /opt/eula.txt
# http://files.minecraftforge.net/maven/net/minecraftforge/forge/${MCVER}-${FORGEVER}/forge-${MCVER}-${FORGEVER}-installer.jar"
RUN cd /opt \
    && wget https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2814/forge-1.12.2-14.23.5.2814-installer.jar \
    && java -jar forge-1.12.2-14.23.5.2814-installer.jar --installServer \
    && echo "eula=true" > eula.txt

RUN mkdir /opt/data

VOLUME [ "/opt/data" ]

WORKDIR /opt

CMD java -jar -Xmx1G -Xms1G  forge-1.12.2-14.23.5.2814-universal.jar