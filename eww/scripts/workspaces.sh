#!/bin/bash

echo "$(hyprctl workspaces -j | jq -c .)"

SOCKET_PATH="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat -u UNIX-CONNECT:"$SOCKET_PATH" STDOUT 2>&1 | while IFS='>>' read -r event data; do
    case "$event" in
        "workspacev2"|"createworkspacev2"|"destroyworkspacev2")
            echo "$(hyprctl workspaces -j | jq -c .)"
            ;;
    esac
done

