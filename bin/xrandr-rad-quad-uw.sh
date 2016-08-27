#!/bin/bash

TOP=DisplayPort-0
BOTTOM=DisplayPort-1

LEFT=DVI-1

# HDMI-0 and DVI-0 share the same graphical output (only one can be used at a time).
RIGHT=HDMI-0
#BOTTOM=DVI-0

# The edge monitors have slightly less vertical resolution than the middle monitors combined,
# so we move the edge monitors down a little bit so that they are centered on the middle ones.
EDGE_Y=$(( (1080*2-1920)/2 ))
RIGHT_X=$((1080+2560))

xrandr \
  --output $TOP --off \
  --output $BOTTOM --off \
  --output $RIGHT --off

sleep 0.2

xrandr \
  --output $LEFT --rotate right --pos 0x${EDGE_Y} --auto \
  --output $BOTTOM --pos 1080x1080 --auto --primary \
  --output $TOP --above $BOTTOM --auto \
  --output $RIGHT --pos ${RIGHT_X}x${EDGE_Y} --rotate left --auto &&

xrandr |grep con
