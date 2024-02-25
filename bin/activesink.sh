#!/bin/bash

set -euo pipefail

function volume_text {
  sink_name=$(pamixer --get-default-sink|tail -1|cut -d'"' -f4)
  echo -e "$sink_name\n\nVolume:  $(pamixer --get-volume-human)"
}

function mic_text {
  echo "Microphone:  $(pamixer --default-source --get-volume-human)"
}

function notify {
  notify-send --app-name "activesink.sh" \
      --transient --urgency low --expire-time 1000 "$1"
}

INC="3"

case "$0" in
  *mic-up)
    pamixer --default-source --increase $INC
    notify "$(mic_text)"
    ;;
  *mic-down)
    pamixer --default-source --decrease $INC
    notify "$(mic_text)"
    ;;
  *mic-mutetoggle)
    pamixer --default-source --toggle-mute
    notify "$(mic_text)"
    ;;
  *up)
    pamixer --increase $INC
    notify "$(volume_text)"
    ;;

  *down)
    pamixer --decrease $INC
    notify "$(volume_text)"
    ;;

  *mutetoggle)
    pamixer --toggle-mute
    notify "$(volume_text)"
    ;;
  *)
    pamixer --list-sources; echo
    pamixer --list-sinks; echo
    pamixer --get-default-sink
    ;;
esac
