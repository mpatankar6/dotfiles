#!/usr/bin/env bash

# If the user decides to change brightness outside of this provided interface,
# this cache is invalid and that change will go unnoticed until the cache is
# rebuilt. Polling is a bad solution; though it could be be non-blocking, it may
# still influence GPU behavior in unexpected ways during the I2C read.
BRIGHTNESS_CACHE="/tmp/monitor-brightness-cache"
BUS_CACHE=/tmp/monitor-bus-cache

BRIGHTNESS_VCP=10
BRIGHTNESS_STEP_PERCENT=5

rebuild_cache() {
  rm -f "$BRIGHTNESS_CACHE"
  rm -f "$BUS_CACHE"
  get_bus && get_brightness
  notify-send "Brightness Cache Rebuilt"
  pkill -RTMIN+1 waybar # Notify Waybar to update
}

# We are only saving the first bus that is in the detect output, thus this
# script does not support >1 monitor.
get_bus() {
  if [[ ! -f "$BUS_CACHE" ]]; then
    ddcutil detect | grep -oP '/dev/i2c-\K\d+' > $BUS_CACHE
  fi
  cat "$BUS_CACHE"
}

get_brightness() {
  if [[ ! -f "$BRIGHTNESS_CACHE" ]]; then
    ddcutil --bus "$(get_bus)" --skip-ddc-checks getvcp "$BRIGHTNESS_VCP" \
      | grep -oP 'current value =\s*\K\d+' \
      > "$BRIGHTNESS_CACHE"
  fi
  cat "$BRIGHTNESS_CACHE"
}

set_brightness() {
  echo "$1" > "$BRIGHTNESS_CACHE"
  pkill -RTMIN+1 waybar # Notify Waybar brightness has changed
  pkill ddcutil 2>/dev/null # Prevent resource contention on the I2C bus
  ddcutil -b "$(get_bus)" --noverify --skip-ddc-checks setvcp \
    "$BRIGHTNESS_VCP" "$1" &
}

increase_brightness() {
    local new=$(( $(get_brightness) + BRIGHTNESS_STEP_PERCENT ))
    (( new > 100 )) && new=100
    set_brightness "$new"
}

decrease_brightness() {
    local new=$(( $(get_brightness) - BRIGHTNESS_STEP_PERCENT ))
    (( new < 0 )) && new=0
    set_brightness "$new"
}

case "$1" in
  "+") increase_brightness ;;
  "-") decrease_brightness ;;
  "") get_brightness ;;
  "rebuild-cache") rebuild_cache ;;
  *) echo "Unknown argument" ;;
esac
