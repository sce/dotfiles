#!/bin/bash

MAIN=${MAIN:-eDP-1}

UWIDE=${UWIDE:-DP-2}
UWIDE2=${UWIDE2:-HDMI-1}

function screen_reset {
  # doing a query first seems to help fix issues with swapping monitors with
  # different specs:
  xrandr -q

  xrandr \
    --output $UWIDE --off --transform none \
    --output $UWIDE2 --off --transform none \
    --output $MAIN --auto --transform none
}

echo "1) starting inital setup ..."

screen_reset
sleep 3

echo "2) initial setup complete, setting up first extra screen ..."

# okay, for some reason turning on the second extra screen with something else
# than pos 0x0 fails when eDP-1 is already on, but if eDP-1 is off and then
# turned on after or together with HDMI-1 then it works.
xrandr \
  --output $UWIDE --auto --pos 0x0 \
  --output $MAIN --off

sleep 3

echo "3) setting up second extra screen ..."

# using --left-of for hdmi-1 refuses to work ...
# 2560x1440 will create a big space underneath the display that's empty/wallpaper,
# but it keeps the remaining picture scaled to correct ratio (16:9)
# --output $MAIN --auto --scale-from 2560x1440
xrandr \
  --output $UWIDE --auto --pos 0x0 \
  --output $UWIDE2 --auto --pos 0x1080 \
  --output $MAIN --auto --pos 2560x0
  #--output $MAIN --auto --pos 2560x0 --scale-from 2560x1440

sleep 3

# echo "3) Done"
echo "3) Reset main monitor"
# Reset scaling if any. This shouldn't be needed, but sometimes xrandr refuses
# to work properly, and doing this seems to create consistent results:
xrandr --output $MAIN --below $UWIDE2 --transform none

sleep 3

echo "4) Scale main monitor"
# Main monitor is physically small compared to the others, so scale it up
# (down?) to make it more comfortable to use:
xrandr --output eDP-1 --scale-from 1920x1080

echo "5) Done"
