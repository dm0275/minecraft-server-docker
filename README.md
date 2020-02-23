# Minecraft Server

## Overview
This project builds a Minecraft (Vanilla or Forge) server Docker image.

## Requirements
* Docker
* Make
* Docker-compose

## Configurable Settings (via environment variables)
|Setting                      |Default Value          |Notes|
|---                          |---                    |---|
|JAVA_MIN_MEM                 |1G                     ||
|JAVA_MAX_MEM                 |2G                     ||
|GAMEMODE                     |0                      |See notes on acceptable values|
|MAXPLAYERS                   |20                     ||
|DIFFICULTY                   |1                      |See notes on acceptable values|
|MOTD                         |Docker Minecraft Server|Message to be displayed in the server list of players. |
|ENABLE_CMD_BLOCK             |null                   ||
|MAX_TICK_TIME                |60000                  ||
|GENERATOR_SETTINGS           |null                   ||
|ALLOW_NETHER                 |true                   ||
|FORCE_GAMEMODE               |false                  ||
|ENABLE_QUERY                 |false                  ||
|PLAYER_IDLE_TIMEOUT          |0                      ||
|SPAWN_MONSTERS               |true                   ||
|OP_PERMISSION_LEVEL          |4                      ||
|PVP                          |true                   ||
|SNOOPER_ENABLED              |true                   ||
|LEVEL_TYPE                   |DEFAULT                ||
|HARDCORE                     |false                  ||
|NETWORK_COMPRESSION_THRESHOLD|256                    ||
|RESOURCE_PACK_SHA1           |null                   ||
|MAX_WORLD_SIZE               |29999984               ||
|SERVER_PORT                  |25565                  ||
|SERVER_IP                    |null                   ||
|SPAWN_NPCS                   |true                   ||
|ALLOW_FLIGHT                 |false                  ||
|LEVEL_NAME                   |world                  ||
|VIEW_DISTANCE                |10                     ||
|RESOURCE_PACK                |null                   ||
|SPAWN_ANIMALS                |true                   ||
|WHITE_LIST                   |false                  ||
|GENERATE_STRUCTURES          |true                   ||
|ONLINE_MODE                  |true                   ||
|MAX_BUILD_HEIGHT             |256                    ||
|LEVEL_SEED                   |null                   ||
|PREVENT_PROXY_CONNECTIONS    |false                  ||
|USE_NATIVE_TRANSPORT         |true                   ||
|ENABLE_RCON                  |false                  ||


_Gamemode: Survival mode is gametype=0, Creative is gametype=1, Adventure is gametype=2, and Spectator is gametype=3_

_Difficulty: Defines the difficulty (such as damage dealt by mobs and the way hunger and poison affects players) of the server. Possible values are 0 (Peaceful)-3(Hard)_

## Usage
```bash
docker run --rm -d -e JAVA_MIN_MEM=3G -e JAVA_MAX_MEM=3G \
    -e GAMEMODE=1 -e MAX_PLAYERS=10 -v $DATA_DIR:/opt/minecraft/data \
    -v $WORLD_DIR:/opt/minecraft/world -v $MODS_DIR:/opt/minecraft/mods -p 25565:25565
    dm0275/minecraft-server:latest
```
Or via Make
```
Usage: make <target>
  build       Build Vanilla image
  build_forge  Build image
  login       Login
  setup       Create DIRs
  run         Run Minecraft in foreground
  rund        Run Minecraft in the background
  stop        Stop Container
  clean       Clean Containers
  setup_forge  Create Forge DIRs
  run_forge   Run Minecraft Forge in foreground
  rund_forge  Run Minecraft Forge in the background
  stop_forge  Stop Container
  clean_forge  Clean Containers
  clean-dirs  Clean DIRs
  help        This help dialog.
```
