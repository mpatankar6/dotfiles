#!/usr/bin/env bash

STATE_FILE="/tmp/hyprsunset-active"

toggle() {
    if [[ -f "$STATE_FILE" ]]; then
        rm "$STATE_FILE"
        hyprctl hyprsunset identity
    else
        touch "$STATE_FILE"
        hyprctl hyprsunset temperature 5500
    fi
    pkill -RTMIN+2 waybar
}

# This status is designed to be parsed by Waybar
status() {
    if [[ -f "$STATE_FILE" ]]; then
        echo '{"class": "active", "tooltip": "Blue Light Filter: On"}'
    else
        echo '{"class": "inactive", "tooltip": "Blue Light Filter: Off"}'
    fi
}

case "$1" in
  status) status ;;
  *) toggle ;;
esac
