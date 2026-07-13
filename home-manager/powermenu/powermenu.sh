#!/usr/bin/env bash

pkill fuzzel && exit 0

choice=$(printf "󰌾 Lock\n󰤄 Suspend\n󰍃 Logout\n󰑐 Reboot\n󰐥 Shutdown" \
  | app2unit -- fuzzel --dmenu --anchor top-left --lines 5 --width 14 \
  | awk '{print $NF}') # Strip the icons

case "$choice" in
  Lock)     loginctl lock-session ;;
  Suspend)  loginctl lock-session && systemctl suspend ;;
  Logout)   uwsm stop ;;
  Reboot)   systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
