#!/bin/bash

MAIN=${MAIN:-eDP-1}
UWIDE=${UWIDE:-DP-2}

# test 1 (-320)
# xrandr --output eDP-1 --scale-from 3520x1840 --output DP-2 --pos 1600x0

# test 2 (-512)
# xrandr --output eDP-1 --scale-from 3328x1628 --output DP-2 --pos 1408x0

# test 3 (-900x-512, 16:9)
# xrandr --output eDP-1 --scale-from 2930x1628 --output DP-2 --pos 1010x0

# test 4 (-944-512, 16:9)
#xrandr \
#  --output eDP-1 --scale-from 2896x1628 \
#  --output DP-2 --auto --mode 1920x1080 --pos 976x0

# test 5
xrandr \
  --output $MAIN --scale-from 2560x1440 \
  --output $UWIDE --auto --mode 1920x1080 --pos 640x0
