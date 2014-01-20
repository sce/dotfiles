#!/bin/bash

ACTIVE_SINK=`pacmd list-sinks|awk '/* index: /{print $3}'`

VOLUP="pactl set-sink-volume $ACTIVE_SINK -- +3%"
VOLDOWN="pactl set-sink-volume $ACTIVE_SINK -- -3%"
MUTETOGGLE="pactl set-sink-mute $ACTIVE_SINK toggle"

case "$0" in
  *up)
    ($VOLUP)
    ;;
  *down)
    ($VOLDOWN)
    ;;
  *mutetoggle)
    ($MUTETOGGLE)
    ;;
  *)
    echo $ACTIVE_SINK
    ;;
esac
