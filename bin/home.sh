#!/bin/bash

MAIN=${MAIN:-eDP-1}

UWIDE=${UWIDE:-DP-2}

VERTICAL=${VERTICAL:-HDMI-1}

function screen_reset {
  # doing a query first seems to help fix issues with swapping monitors with
  # different specs:
  xrandr -q

  xrandr \
    --output $UWIDE --off --transform none \
    --output $VERTICAL --off --transform none \
    --output $MAIN --auto --transform none
}

echo "1) starting inital setup ..."
screen_reset
sleep 2

echo "2) setting up screens ..."

# using --left-of for hdmi-1 refuses to work ...
# 2560x1440 will create a big space underneath the display that's empty/wallpaper,
# but it keeps the remaining picture scaled to correct ratio (16:9)
# --output $MAIN --auto --scale-from 2560x1440
xrandr \
  --output $UWIDE --auto --pos 0x0 \
  --output $VERTICAL --auto --pos 2560x0 --rotate left \
  --output $MAIN --auto

echo "3) Done"
