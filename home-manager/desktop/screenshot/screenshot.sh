#!/usr/bin/env bash

# This is needed for the region case to fail if no screenshot was taken.
set -o pipefail

# This is for the notification sent after a capture.
TEMP="/tmp/screenshot.png"

case "$1" in
  full)
    if grim "$TEMP" && wl-copy < "$TEMP"; then
      notify-send -i "$TEMP" "Screenshot" "Full screen copied to clipboard"
    fi
    ;;
  region)
    # Exit if slurp is already running
    if pgrep -x "slurp" > /dev/null; then exit; fi

    if grim -g "$(slurp)" "$TEMP" && wl-copy < "$TEMP"; then
      notify-send -i "$TEMP" "Screenshot" "Region copied to clipboard"
    fi
    ;;
  save)
    FILE=$HOME/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
    mkdir -p "$HOME"/Screenshots
    wl-paste --type image/png 2>/dev/null > "$FILE"
    if [[ -s "$FILE" ]]; then
      notify-send -i "$FILE" "Screenshot" "Saved to $FILE"
    else
      # If wl-paste failed or the clipboard did not contain a PNG, an empty
      # file was probably written.
      rm -f "$FILE"
      notify-send "Screenshot" "Nothing was saved"
    fi
    ;;
esac
