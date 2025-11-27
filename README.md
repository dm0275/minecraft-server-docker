# Minecraft Server

## Overview
This project creates Docker images for running Minecraft servers, supporting both Vanilla and Forge versions.

## Requirements
* Docker
* Docker-compose

## Configurable Settings (via environment variables)
| Setting                       | Default Value           | Notes                                                  |
|-------------------------------|-------------------------|--------------------------------------------------------|
| JAVA_MIN_MEM                  | 1G                      |                                                        |
| JAVA_MAX_MEM                  | 2G                      |                                                        |
| GAMEMODE                      | 0                       | See notes on acceptable values                         |
| MAXPLAYERS                    | 20                      |                                                        |
| DIFFICULTY                    | 1                       | See notes on acceptable values                         |
| MOTD                          | Docker Minecraft Server | Message to be displayed in the server list of players. |
| ENABLE_CMD_BLOCK              | null                    |                                                        |
| MAX_TICK_TIME                 | 60000                   |                                                        |
| GENERATOR_SETTINGS            | null                    |                                                        |
| ALLOW_NETHER                  | true                    |                                                        |
| FORCE_GAMEMODE                | false                   |                                                        |
| ENABLE_QUERY                  | false                   |                                                        |
| PLAYER_IDLE_TIMEOUT           | 0                       |                                                        |
| SPAWN_MONSTERS                | true                    |                                                        |
| OP_PERMISSION_LEVEL           | 4                       |                                                        |
| PVP                           | true                    |                                                        |
| SNOOPER_ENABLED               | true                    |                                                        |
| LEVEL_TYPE                    | DEFAULT                 |                                                        |
| HARDCORE                      | false                   |                                                        |
| NETWORK_COMPRESSION_THRESHOLD | 256                     |                                                        |
| RESOURCE_PACK_SHA1            | null                    |                                                        |
| MAX_WORLD_SIZE                | 29999984                |                                                        |
| SERVER_PORT                   | 25565                   |                                                        |
| SERVER_IP                     | null                    |                                                        |
| SPAWN_NPCS                    | true                    |                                                        |
| ALLOW_FLIGHT                  | false                   |                                                        |
| LEVEL_NAME                    | world                   |                                                        |
| VIEW_DISTANCE                 | 10                      |                                                        |
| RESOURCE_PACK                 | null                    |                                                        |
| SPAWN_ANIMALS                 | true                    |                                                        |
| WHITE_LIST                    | false                   |                                                        |
| GENERATE_STRUCTURES           | true                    |                                                        |
| ONLINE_MODE                   | true                    |                                                        |
| MAX_BUILD_HEIGHT              | 256                     |                                                        |
| LEVEL_SEED                    | null                    |                                                        |
| PREVENT_PROXY_CONNECTIONS     | false                   |                                                        |
| USE_NATIVE_TRANSPORT          | true                    |                                                        |
| ENABLE_RCON                   | false                   |                                                        |
| RCON_PORT                     | 25575                   | Publish this port (e.g., `-p 25575:25575`) when RCON is enabled. |
| RCON_PASSWORD                 | null                    | Required for RCON connections when `ENABLE_RCON=true`.  |


_Gamemode: Survival mode is gametype=0, Creative is gametype=1, Adventure is gametype=2, and Spectator is gametype=3_

_Difficulty: Defines the difficulty (such as damage dealt by mobs and the way hunger and poison affects players) of the server. Possible values are 0 (Peaceful)-3(Hard)_

## Usage
The recommended method to start Minecraft servers is by using the `mcrun` CLI tool, which can be downloaded from [here](https://github.com/dm0275/mcrun).

To start a Forge server, use the following command:

```bash
mcrun forge start --world-name <world_name>
```

Additional flags are also available to customize the server configuration:

```bash
Usage:
  mcrun forge start [flags]

Flags:
      --enable-cmd-block    Enable Command Block (default: true)
      --gamemode string     Set Gamemode: 0 for Survival, 1 for Creative, 2 for Adventure, and 3 for Spectator (default: "0")
  -h, --help                Display help for the start command
      --max-memory string   Set maximum memory limit (default: "3G")
      --min-memory string   Set minimum memory limit (default: "3G")
      --port string         Specify server port (default: "25565")
      --seed string         Set Minecraft world seed
      --version string      Specify Minecraft version (default: "forge-1.20.1")
      --world-name string   Set a name for the Minecraft server
```

Alternatively, you can run the server directly using Docker:

```bash
docker run --rm -d -e JAVA_MIN_MEM=3G -e JAVA_MAX_MEM=3G \
    -e GAMEMODE=1 -e MAX_PLAYERS=10 \
    -v $WORLD_DIR:/opt/minecraft/world -v $MODS_DIR:/opt/minecraft/mods -p 25565:25565 \
    dm0275/minecraft-server:latest
```

To enable RCON, add `-e ENABLE_RCON=true -e RCON_PASSWORD=<secret> [-e RCON_PORT=25575]` and publish the RCON port (default `-p 25575:25575`).

## Building from Source
The following tasks are available for building Minecraft server images:

```plaintext
Minecraft tasks
---------------
buildForge1.12.2 - Build Minecraft Forge server v1.12.2 image (forge v14.23.5.2859)
buildForge1.13.2 - Build Minecraft Forge server v1.13.2 image (forge v25.0.223)
buildForge1.14.4 - Build Minecraft Forge server v1.14.4 image (forge v28.2.26)
buildForge1.15.2 - Build Minecraft Forge server v1.15.2 image (forge v31.2.57)
buildForge1.16.5 - Build Minecraft Forge server v1.16.5 image (forge v36.2.42)
buildForge1.18.2 - Build Minecraft Forge server v1.18.2 image (forge v40.2.21)
buildForge1.19.2 - Build Minecraft Forge server v1.19.2 image (forge v43.3.0)
buildForge1.19.3 - Build Minecraft Forge server v1.19.3 image (forge v44.1.0)
buildForge1.20.1 - Build Minecraft Forge server v1.20.1 image (forge v47.3.6)
buildForge1.20.4 - Build Minecraft Forge server v1.20.4 image (forge v49.0.22)
buildVanilla1.13.2 - Build Minecraft server v1.13.2 image
buildVanilla1.14.4 - Build Minecraft server v1.14.4 image
buildVanilla1.15.2 - Build Minecraft server v1.15.2 image
buildVanilla1.16.5 - Build Minecraft server v1.16.5 image
buildVanilla1.17.1 - Build Minecraft server v1.17.1 image
buildVanilla1.18.1 - Build Minecraft server v1.18.1 image
buildVanilla1.19.2 - Build Minecraft server v1.19.2 image
buildVanilla1.19.3 - Build Minecraft server v1.19.3 image
```
