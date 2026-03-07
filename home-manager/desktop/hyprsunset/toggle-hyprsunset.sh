#!/usr/bin/env bash

STATE_FILE="/tmp/hyprsunset-active"
TEMPERATURE=5500

toggle() {
    if [[ -f "$STATE_FILE" ]]; then
        rm "$STATE_FILE"
        hyprctl hyprsunset identity
    else
        touch "$STATE_FILE"
        hyprctl hyprsunset temperature $TEMPERATURE
    fi
    pkill -RTMIN+2 waybar
}

resume() {
  if [[ -f "$STATE_FILE" ]]; then
    hyprctl hyprsunset temperature $TEMPERATURE
  fi
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
  resume) resume ;;
  status) status ;;
  *) toggle ;;
esac
