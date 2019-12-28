# Minecraft Server

## Overview
This project builds a Minecraft (Vanilla or Forge) server Docker image.

## Requirements
* Docker
* Make
* Docker-compose

## Configurable Settings (via environment variables)
|Setting          |Default Value          |Notes|
|---              |---                    |---|
|JAVA_MIN_MEM     |1G                     ||
|JAVA_MAX_MEM     |2G                     ||
|GAMEMODE         |0                      |See notes on acceptable values|
|MAXPLAYERS       |20                     ||
|DIFFICULTY       |1                      |See notes on acceptable values|
|MOTD             |Docker Minecraft Server|Message to be displayed in the server list of players. |
|ENABLE_CMD_BLOCK |N/A                    ||

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
