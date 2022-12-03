# Minecraft Server

## Overview
This project builds a Minecraft (Vanilla or Forge) server Docker image.

## Requirements
* Docker
* Gradle
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
Or via Gradle
```
./gradlew run
```
Additionally, the following tasks are available to build and run Minecraft:
```
Mincraft tasks
--------------
buildAllForge - Build All Minecraft server images
buildForge1.13.2 - Build Forge Minecraft server v1.13.2 image (forge v25.0.219)
buildForge1.14.4 - Build Forge Minecraft server v1.14.4 image (forge v28.2.1)
buildForge1.15.2 - Build Forge Minecraft server v1.15.2 image (forge v31.2.0)
buildForge1.16.4 - Build Forge Minecraft server v1.16.4 image (forge v35.1.4)
buildVanilla1.13.2 - Build Minecraft server v1.13.2 image
buildVanilla1.14.4 - Build Minecraft server v1.14.4 image
buildVanilla1.15.2 - Build Minecraft server v1.15.2 image
buildVanilla1.16.4 - Build Minecraft server v1.16.4 image
pushAllForge - Build All Forge Minecraft server images
pushForge1.13.2 - Push Forge Minecraft server v1.13.2 image
pushForge1.14.4 - Push Forge Minecraft server v1.14.4 image
pushForge1.15.2 - Push Forge Minecraft server v1.15.2 image
pushForge1.16.4 - Push Forge Minecraft server v1.16.4 image
pushVanilla1.13.2 - Push Minecraft server v1.13.2 image
pushVanilla1.14.4 - Push Minecraft server v1.14.4 image
pushVanilla1.15.2 - Push Minecraft server v1.15.2 image
pushVanilla1.16.4 - Push Minecraft server v1.16.4 image
run - Run the latest Minecraft server image
runBackground - Run the latest Minecraft server image (daemonized)
runBackgroundForge - Run the latest Forge Minecraft server image (daemonized)
runForge - Run the latest Forge Minecraft server image
setup - Setup the Minecraft directories
setupForge - Setup the Minecraft (forge) directories
```
