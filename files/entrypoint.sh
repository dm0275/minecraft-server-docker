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

  exec "$@"
fi

exec "$@"