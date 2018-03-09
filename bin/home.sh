#!/bin/bash

MAIN=${MAIN:-eDP-1}

UWIDE=${UWIDE:-DP-2}

VERTICAL=${VERTICAL:-HDMI-1}

function screen_reset {
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
}

echo "1) starting inital setup ..."
screen_reset
sleep 2

echo "2) initial setup complete, setting up first extra screen ..."

# xrandr \
#   --output $UWIDE --auto --pos 0x0 \
#   --output $MAIN --off
#
# sleep 2

echo "3) setting up second extra screen ..."

# using --left-of for hdmi-1 refuses to work ...
# 2560x1440 will create a big space underneath the display that's empty/wallpaper,
# but it keeps the remaining picture scaled to correct ratio (16:9)
# --output $MAIN --auto --scale-from 2560x1440
xrandr \
  --output $UWIDE --auto --pos 0x0 \
  --output $VERTICAL --auto --pos 2560x0 --rotate left \
  --output $MAIN --auto

echo "4) Done"
