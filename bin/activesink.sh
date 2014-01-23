#!/bin/bash

ACTIVE_SINK=`pacmd list-sinks|awk '/* index: /{print $3}'`

function curlevel {
  pacmd list-sinks|grep -A 15 '* index'|awk '/volume:/{ print $5 }'|head -1
}

function muted {
  local MUTED=$(pacmd list-sinks|grep -A 15 '* index'|awk '/muted: /{ print $2 }')
  [ "$MUTED" == "yes" ] && echo "(MUTED)" || echo ""
}

function volume_text {
  echo "Volume $(curlevel) $(muted)"
}

function notify_volume {
  notify-send -u low "$(volume_text)"
}

INC="3%"
function volup { pactl set-sink-volume $ACTIVE_SINK -- +$INC; }
function voldown { pactl set-sink-volume $ACTIVE_SINK -- -$INC; }
function mutetoggle { pactl set-sink-mute $ACTIVE_SINK toggle; unset MUTED; }

case "$0" in
  *up)
    volup
    notify_volume
    ;;

  *down)
    voldown
    notify_volume
    ;;

  *mutetoggle)
    mutetoggle
    notify_volume
    ;;
  *)
    echo $ACTIVE_SINK
    ;;
esac
