#!/bin/bash

echo "FUCK NIGGA"
echo "$(hyprctl activeworkspace -j | jq -c .)"

SOCKET_PATH="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat -u UNIX-CONNECT:"$SOCKET_PATH" STDOUT 2>&1 | while IFS='>>' read -r event data; do
    case "$event" in
        "workspacev2")
            echo "$(hyprctl activeworkspace -j | jq -c .)"
            ;;
    esac
done
