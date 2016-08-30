#!/bin/bash

main=eDP-1
second=HDMI-1
third=DP-2

#dpi=220
dpi=96
dpi=144

# built-in laptop monitor:
main_res=1920x1440
main_res=2048x1536
main_res=1856x1392
main_res=1792x1344

main_res=1600x1200
main_res=3840x2160

# second monitor: physically bigger (27"), so we want this to be primary:
sec_res=1920x1200
sec_res=1920x1080
sec_res=3840x2160

# third monitor: 24":
th_res=1920x1200
th_res=1920x1080
xrandr --output $main --auto --mode $main_res --dpi $dpi

sleep 1

# using auto here will "turn off" the display if the monitor is disconnected:
xrandr --output $second --auto --primary
xrandr --output $third --auto

sleep 1

# but if it's conncted we want to configure it properly:
# (Machine doesn't support more than 8k horizontal resolution... so turn off main screen)
xrandr --output $second --left-of $main --mode $sec_res --auto --dpi $dpi --primary &&
  xrandr --output $main --off &&
  xrandr --output $third --left-of $second --mode $th_res --auto --dpi 96

echo Done.

xrandr|grep " con"
