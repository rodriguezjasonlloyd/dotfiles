#!/bin/bash

SOCKET_PATH="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

echo "$(hyprctl activewindow -j | jq -c .)"

socat -u UNIX-CONNECT:"$SOCKET_PATH" STDOUT 2>&1 | while IFS='>>' read -r event data; do
    case "$event" in
        "activewindowv2")
            echo "$(hyprctl activewindow -j | jq -c .)"
            ;;
    esac
done
