#!/usr/bin/env bash

# This is needed for the region case to fail if no screenshot was taken.
set -o pipefail

case "$1" in
  full)
    if grim - | wl-copy; then
      notify-send "Screenshot" "Full screen copied to clipboard"
    fi
    ;;
  region)
    if grim -g "$(slurp)" - | wl-copy; then
      notify-send "Screenshot" "Region copied to clipboard"
    fi
    ;;
  save)
    FILE=$HOME/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
    mkdir -p $HOME/Screenshots
    wl-paste --type image/png 2>/dev/null > "$FILE"
    if [[ -s "$FILE" ]]; then
      notify-send "Screenshot" "Saved to $FILE"
    else
      # If wl-paste failed or the clipboard did not contain a PNG, an empty
      # file was probably written.
      rm -f "$FILE"
    fi
    ;;
esac
