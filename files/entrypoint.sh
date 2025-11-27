#!/usr/bin/env bash

set -e

if [[ "$DEBUG" == "true" ]]; then
    set -x
fi

replace_prop() {
    local key="$1"
    local value="$2"
    local file="${MINECRAFT_HOME}/server.properties"

    [ -z "$value" ] && return

    # If the key is missing, append it instead of relying on in-place rename.
    if ! grep -q "^${key}=" "$file"; then
        echo "Adding ${key}=${value} to server.properties"
        printf '%s=%s\n' "$key" "$value" >> "$file"
        return
    fi

    local tmp old_line
    old_line="$(grep -m1 "^${key}=" "$file" || true)"
    tmp="$(mktemp)"
    sed "s|^${key}=.*|${key}=${value}|" "$file" > "$tmp"
    echo "Updating ${key}: ${old_line#*=} -> ${value}"
    cat "$tmp" > "$file"
    rm -f "$tmp"
}

function update_generated_properties() {
    replace_prop "gamemode" "$GAMEMODE"
    replace_prop "max-players" "$MAX_PLAYERS"
    replace_prop "difficulty" "$DIFFICULTY"
    replace_prop "motd" "$MOTD"
    replace_prop "enable-command-block" "$ENABLE_CMD_BLOCK"
    replace_prop "max-tick-time" "$MAX_TICK_TIME"
    replace_prop "generator-settings" "$GENERATOR_SETTINGS"
    replace_prop "allow-nether" "$ALLOW_NETHER"
    replace_prop "force-gamemode" "$FORCE_GAMEMODE"
    replace_prop "enable-query" "$ENABLE_QUERY"
    replace_prop "player-idle-timeout" "$PLAYER_IDLE_TIMEOUT"
    replace_prop "spawn-monsters" "$SPAWN_MONSTERS"
    replace_prop "op-permission-level" "$OP_PERMISSION_LEVEL"
    replace_prop "pvp" "$PVP"
    replace_prop "snooper-enabled" "$SNOOPER_ENABLED"
    replace_prop "level-type" "$LEVEL_TYPE"
    replace_prop "hardcore" "$HARDCORE"
    replace_prop "max-players" "$MAX_PLAYER"
    replace_prop "network-compression-threshold" "$NETWORK_COMPRESSION_THRESHOLD"
    replace_prop "resource-pack-sha1" "$RESOURCE_PACK_SHA1"
    replace_prop "max-world-size" "$MAX_WORLD_SIZE"
    replace_prop "server-port" "$SERVER_PORT"
    replace_prop "server-ip" "$SERVER_IP"
    replace_prop "spawn-npcs" "$SPAWN_NPCS"
    replace_prop "allow-flight" "$ALLOW_FLIGHT"
    replace_prop "level-name" "$LEVEL_NAME"
    replace_prop "view-distance" "$VIEW_DISTANCE"
    replace_prop "resource-pack" "$RESOURCE_PACK"
    replace_prop "spawn-animals" "$SPAWN_ANIMALS"
    replace_prop "white-list" "$WHITE_LIST"
    replace_prop "generate-structures" "$GENERATE_STRUCTURES"
    replace_prop "online-mode" "$ONLINE_MODE"
    replace_prop "max-build-height" "$MAX_BUILD_HEIGHT"
    replace_prop "level-seed" "$LEVEL_SEED"
    replace_prop "prevent-proxy-connections" "$PREVENT_PROXY_CONNECTIONS"
    replace_prop "use-native-transport" "$USE_NATIVE_TRANSPORT"
    replace_prop "enable-rcon" "$ENABLE_RCON"
    replace_prop "rcon.port" "$RCON_PORT"
    replace_prop "rcon.password" "$RCON_PASSWORD"
}


if [ "$2" == 'start-minecraft.sh' ]; then
    if [[ "$LOAD_PROPERTY_FILE" == 'true' && -f "${MINECRAFT_HOME}/server.properties" ]]; then
      echo "Using local server.properties file"
    else
        echo "File server.properties does not exist, creating local file"
        cp "${MINECRAFT_HOME}/server.properties.bk" "${MINECRAFT_HOME}/server.properties"
    fi

    update_generated_properties

    exec "$@"
fi

exec "$@"
