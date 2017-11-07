#!/bin/bash

MAIN=${MAIN:-eDP-1}

UWIDE=${UWIDE:-DP-2}

VERTICAL=${VERTICAL:-HDMI-1}

echo "1) starting inital setup ..."

# doing a query first seems to help fix issues with swapping monitors with
# different specs:
xrandr -q

# okay, for some reason turning on the second extra screen with something else
# than pos 0x0 fails when eDP-1 is already on, but if eDP-1 is off and then
# turned on after or together with HDMI-1 then it works.
xrandr \
  --output $UWIDE --off --transform none \
  --output $VERTICAL --off --transform none \
  --output $MAIN --auto --transform none
  # --output $MAIN --auto --scale-from 2560x1440
  #--output $MAIN --mode 3840x2160 --scale-from 2560x1440
  # 1440 will create a big space underneith the display that's empty/wallpaper,
  # but it keeps the remaining picture scaled to correct ratio (16:9)

sleep 3

echo "2) initial setup complete, setting up first extra screen ..."

#xrandr --output $VERTICAL --auto --left-of $MAIN --rotate right
  # --output $MAIN --auto --scale-from 2560x1080 --pos 0x0 \
xrandr \
  --output $UWIDE --auto --pos 0x0 \
  --output $MAIN --off
  #--output $MAIN --pos 0x0 \
  #--output $UWIDE --auto --mode 2560x1080 --same-as $MAIN
  # --output $VERTICAL --auto --pos 2560x0 --rotate right

sleep 2

echo "3) setting up second extra screen ..."

#xrandr --output $MAIN --scale-from 2560x1080 --output $UWIDE --auto
# using --left-of for hdmi-1 refuses to work ...
xrandr \
  --output $UWIDE --auto \
  --output $VERTICAL --auto --pos 2560x0 --rotate left \
  --output $MAIN --auto --scale-from 2560x1440
  #--output $VERTICAL --auto --right-of $UWIDE --rotate left

#xrandr \
  #--output $UWIDE --auto --pos 1080x0

echo "4) Done"
