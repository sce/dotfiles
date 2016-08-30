#!/bin/bash

main=eDP-1
second=HDMI-1

#dpi=220
dpi=144
dpi=96

# built-in laptop monitor:
res=1920x1440
res=2048x1536
res=1856x1392
res=1792x1344

res=1600x1200
res=3840x2160
xrandr --output $main --auto --mode $res --dpi $dpi

sleep 1

# second monitor: physically bigger, so we want this to be primary:
res=1920x1200
res=1920x1080
res=3840x2160
# using auto here will "turn off" the display if the monitor is disconnected:
xrandr --output $second --auto --primary

# but if it's conncted we want to configure it properly:
xrandr --output $second --left-of $main --mode $res --auto --dpi $dpi --primary

echo Done.

xrandr|grep " con"
