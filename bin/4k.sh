#!/bin/bash

main=eDP-1
second=HDMI-1
third=DP-2

#big_dpi=220
big_dpi=96
big_dpi=144

# built-in laptop monitor:
main_res=2048x1536
main_res=1856x1392
main_res=1792x1344

main_res=1600x1200
main_res=3840x2160
main_res=1920x1440

# second monitor: physically bigger (27"), so we want this to be primary:
sec_res=1920x1200
sec_res=1920x1080
sec_res=3840x2160

# third monitor: 24":
th_res=1920x1080
th_res=1920x1200 # native
xrandr --output $main --auto --mode $main_res --dpi $big_dpi

sleep 1

# using auto here will "turn off" the display if the monitor is disconnected:
#xrandr --output $second --auto --primary
#xrandr --output $third --auto

# the display driver can get confused when add/removing displays, so better turn off and on again:
xrandr --output $second --off
xrandr --output $third --off

sleep 1

# but if it's conncted we want to configure it properly:
# (Machine doesn't support more than 8k horizontal resolution... so turn off main screen)
# We need to scale the third monitor so the system thinks it has twice as big
# resolution. Doing this will prevent the interface from being a nice size on
# the 4k monitor and way too big on the third one.
# hmm, maybe just mirror the laptop monitor onto third display and scale appropriately?
xrandr --output $second --right-of $main --mode $sec_res --auto --dpi $big_dpi --primary &&
  xrandr --output $third --same-as $main --dpi 96 --mode $th_res --auto --scale 1x1.2

echo Done.

xrandr|grep " con"
