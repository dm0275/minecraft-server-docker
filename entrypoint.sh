#!/usr/bin/env bash

set -exo pipefail

if [ "$2" == 'start-minecraft.sh' ]; then

  if [ "$GAMEMODE" != '' ]; then
    sed -e "s|gamemode.*|gamemode=$GAMEMODE|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi

  if [ "$MAX_PLAYERS" != '' ]; then
    sed -e "s|max-players.*|max-players=$MAX_PLAYERS|g" \
     -i "${MINECRAFT_HOME}/server.properties"
  fi

  exec "$@"
fi

exec "$@"