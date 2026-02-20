#!/usr/bin/env bash
case "$1" in
  full)
    grim - | wl-copy
    notify-send "Screenshot" "Full screen copied to clipboard"
    ;;
  region)
    grim -g "$(slurp)" - | wl-copy
    notify-send "Screenshot" "Region copied to clipboard"
    ;;
  save)
    OUTPUT=$HOME/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
    wl-paste --type image/png > "$OUTPUT"
    notify-send "Screenshot" "Saved to $OUTPUT"
    ;;
esac
