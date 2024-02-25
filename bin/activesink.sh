#!/bin/bash

set -euo pipefail

function volume_text {
  echo $(pamixer --get-volume-human)
}

function notify_volume {
  notify-send -u low -t 1000 "$(volume_text)"
}

INC="3"

case "$0" in
  *up)
    pamixer --increase $INC
    notify_volume
    ;;

  *down)
    pamixer --decrease $INC
    notify_volume
    ;;

  *mutetoggle)
    pamixer --toggle-mute
    notify_volume
    ;;
  *)
    exec pamixer --get-default-sink
    ;;
esac
