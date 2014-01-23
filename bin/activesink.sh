#!/bin/bash

ACTIVE_SINK=`pacmd list-sinks|awk '/* index: /{print $3}'`

function set_curlevel {
  CURLEVEL=$(pacmd list-sinks|grep -A 15 '* index'|awk '/volume:/{ print $5 }'|head -1)
}

function set_muted {
  if [ ! "$MUTED" ]; then
    MUTED=$(pacmd list-sinks|grep -A 15 '* index'|awk '/muted: /{ print $2 }')
    [ "$MUTED" == "yes" ] && MUTED_TEXT="(MUTED)" || unset MUTED_TEXT
  fi
}

function volume_text {
  set_curlevel
  set_muted
  echo "Volume $CURLEVEL $MUTED_TEXT"
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
