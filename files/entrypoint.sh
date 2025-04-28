#!/usr/bin/env bash

set -ex

if [ -f "${MINECRAFT_HOME}/server.properties" ]; then
    echo "✅ server.properties exists."
    ls "${MINECRAFT_HOME}/server.properties"
    cat "${MINECRAFT_HOME}/server.properties"
else
    echo "❌ server.properties does not exist, creating temp file"
    cp "${MINECRAFT_HOME}/server.properties.bk" "${MINECRAFT_HOME}/server.properties"
fi

if [ "$2" == 'start-minecraft.sh' ]; then

  if [ "$GAMEMODE" != '' ]; then
    sed -e "s|gamemode.*|gamemode=$GAMEMODE|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi

  if [ "$MAX_PLAYERS" != '' ]; then
    sed -e "s|max-players.*|max-players=$MAX_PLAYERS|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi

  if [ "$DIFFICULTY" != '' ]; then
    sed -e "s|difficulty.*|difficulty=$DIFFICULTY|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi

  if [ "$MOTD" != '' ]; then
    sed -e "s|motd.*|motd=$MOTD|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi

  if [ "$ENABLE_CMD_BLOCK" == 'true' ]; then
    sed -e "s|enable-command-block.*|enable-command-block=$ENABLE_CMD_BLOCK|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi

  if [ "$MAX_TICK_TIME" != '' ]; then
    sed -e "s|max-tick-time.*|max-tick-time=$MAX_TICK_TIME|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$GENERATOR_SETTINGS" != '' ]; then
    sed -e "s|generator-settings.*|generator-settings=$GENERATOR_SETTINGS|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$ALLOW_NETHER" != '' ]; then
    sed -e "s|allow-nether.*|allow-nether=$ALLOW_NETHER|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$FORCE_GAMEMODE" != '' ]; then
    sed -e "s|force-gamemode.*|force-gamemode=$FORCE_GAMEMODE|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$ENABLE_QUERY" != '' ]; then
    sed -e "s|enable-query.*|enable-query=$ENABLE_QUERY|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$PLAYER_IDLE_TIMEOUT" != '' ]; then
    sed -e "s|player-idle-timeout.*|player-idle-timeout=$PLAYER_IDLE_TIMEOUT|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$SPAWN_MONSTERS" != '' ]; then
    sed -e "s|spawn-monsters.*|spawn-monsters=$SPAWN_MONSTERS|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$OP_PERMISSION_LEVEL" != '' ]; then
    sed -e "s|op-permission-level.*|op-permission-level=$OP_PERMISSION_LEVEL|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$PVP" != '' ]; then
    sed -e "s|pvp.*|pvp=$PVP|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$SNOOPER_ENABLED" != '' ]; then
    sed -e "s|snooper-enabled.*|snooper-enabled=$SNOOPER_ENABLED|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$LEVEL_TYPE" != '' ]; then
    sed -e "s|level-type.*|level-type=$LEVEL_TYPE|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$HARDCORE" != '' ]; then
    sed -e "s|hardcore.*|hardcore=$HARDCORE|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$MAX_PLAYER" != '' ]; then
    sed -e "s|max-players.*|max-players=$MAX_PLAYER|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$NETWORK_COMPRESSION_THRESHOLD" != '' ]; then
    sed -e "s|network-compression-threshold.*|network-compression-threshold=$NETWORK_COMPRESSION_THRESHOLD|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$RESOURCE_PACK_SHA1" != '' ]; then
    sed -e "s|resource-pack-sha1.*|resource-pack-sha1=$RESOURCE_PACK_SHA1|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$MAX_WORLD_SIZE" != '' ]; then
    sed -e "s|max-world-size.*|max-world-size=$MAX_WORLD_SIZE|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$SERVER_PORT" != '' ]; then
    sed -e "s|server-port.*|server-port=$SERVER_PORT|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$SERVER_IP" != '' ]; then
    sed -e "s|server-ip.*|server-ip=$SERVER_IP|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$SPAWN_NPCS" != '' ]; then
    sed -e "s|spawn-npcs.*|spawn-npcs=$SPAWN_NPCS|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$ALLOW_FLIGHT" != '' ]; then
    sed -e "s|allow-flight.*|allow-flight=$ALLOW_FLIGHT|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$LEVEL_NAME" != '' ]; then
    sed -e "s|level-name.*|level-name=$LEVEL_NAME|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$VIEW_DISTANCE" != '' ]; then
    sed -e "s|view-distance.*|view-distance=$VIEW_DISTANCE|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$RESOURCE_PACK" != '' ]; then
    sed -e "s|resource-pack.*|resource-pack=$RESOURCE_PACK|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$SPAWN_ANIMALS" != '' ]; then
    sed -e "s|spawn-animals.*|spawn-animals=$SPAWN_ANIMALS|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$WHITE_LIST" != '' ]; then
    sed -e "s|white-list.*|white-list=$WHITE_LIST|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$GENERATE_STRUCTURES" != '' ]; then
    sed -e "s|generate-structures.*|generate-structures=$GENERATE_STRUCTURES|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$ONLINE_MODE" != '' ]; then
    sed -e "s|online-mode.*|online-mode=$ONLINE_MODE|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$MAX_BUILD_HEIGHT" != '' ]; then
    sed -e "s|max-build-height.*|max-build-height=$MAX_BUILD_HEIGHT|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$LEVEL_SEED" != '' ]; then
    sed -e "s|level-seed.*|level-seed=$LEVEL_SEED|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$PREVENT_PROXY_CONNECTIONS" != '' ]; then
    sed -e "s|prevent-proxy-connections.*|prevent-proxy-connections=$PREVENT_PROXY_CONNECTIONS|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$USE_NATIVE_TRANSPORT" != '' ]; then
    sed -e "s|use-native-transport.*|use-native-transport=$USE_NATIVE_TRANSPORT|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi


  if [ "$ENABLE_RCON" != '' ]; then
    sed -e "s|enable-rcon.*|enable-rcon=$ENABLE_RCON|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi

  exec "$@"
fi

exec "$@"