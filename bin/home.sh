#!/bin/bash

echo "1) starting inital setup ..."

# okay, for some reason turning on the second extra screen with something else
# than pos 0x0 fails when eDP-1 is already on, but if eDP-1 is off and then
# turned on after or together with HDMI-1 then it works.
xrandr \
  --output DP-2 --off --transform none \
  --output HDMI-1 --off --transform none \
  --output eDP-1 --auto --transform none
  # --output eDP-1 --auto --scale-from 2560x1440
  #--output eDP-1 --mode 3840x2160 --scale-from 2560x1440
  # 1440 will create a big space underneith the display that's empty/wallpaper,
  # but it keeps the remaining picture scaled to correct ratio (16:9)

sleep 3

echo "2) initial setup complete, setting up first extra screen ..."

#xrandr --output HDMI-1 --auto --left-of eDP-1 --rotate right
  # --output eDP-1 --auto --scale-from 2560x1080 --pos 0x0 \
xrandr \
  --output DP-2 --auto --pos 0x0 \
  --output eDP-1 --off
  #--output eDP-1 --pos 0x0 \
  #--output DP-2 --auto --mode 2560x1080 --same-as eDP-1
  # --output HDMI-1 --auto --pos 2560x0 --rotate right

sleep 2

echo "3) setting up second extra screen ..."

#xrandr --output eDP-1 --scale-from 2560x1080 --output DP-2 --auto
# using --left-of for hdmi-1 refuses to work ...
xrandr \
  --output DP-2 --auto \
  --output HDMI-1 --auto --pos 2560x0 --rotate left \
  --output eDP-1 --auto --scale-from 2560x1440
  #--output HDMI-1 --auto --right-of DP-2 --rotate left

#xrandr \
  #--output DP-2 --auto --pos 1080x0

echo "4) Done"
