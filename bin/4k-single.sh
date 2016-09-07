#!/bin/bash

main=eDP-1
second=HDMI-1
third=DP-2

xrandr \
  --output $second --off \
  --output $third --off \
  --output $main --auto --transform none
