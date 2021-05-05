#!/bin/bash

set -euo pipefail

#ACTIVE_SINK="@DEFAULT_SINK@"
ACTIVE_SINK=`pactl info| awk '/Default Sink:/{ print $3 }'`

if [ "$ACTIVE_SINK" == "" ]; then
  notify-send -u critical "Volume: Failed to fetch active sink"
  exit 1
fi

function volume_text {
  echo $(pactl list sinks|awk '/\tVolume/{ print $5 } /Mute/{ print "mute:" $2 } /Description/{ print $2 } /Formats/{ print "\r" }')
}

function notify_volume {
  notify-send -u low -t 1000 "$(volume_text)"
}

INC="3%"
function volup { pactl set-sink-volume $ACTIVE_SINK +$INC; }
function voldown { pactl set-sink-volume $ACTIVE_SINK -$INC; }
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
