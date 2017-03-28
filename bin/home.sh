#!/bin/bash

echo starting inital setup ...

xrandr \
  --output DP-2 --off --transform none \
  --output HDMI-1 --off --transform none \
  --output eDP-1 --mode 3840x2160 --scale-from 2560x1080

sleep 3

echo initial setup complete, setting up first extra screen ...

xrandr \
  --output eDP-1 --pos 0x0 \
  --output DP-2 --auto --same-as eDP-1

sleep 2

echo setting up second extra screen ...

xrandr \
  --output DP-2 --auto \
  --output HDMI-1 --auto --pos 2560x0 --rotate left

echo Done
