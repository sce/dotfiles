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
main_res=1920x1440
main_res=3840x2160

# second monitor: physically bigger (27"), so we want this to be primary:
sec_res=1920x1200
sec_res=1920x1080
sec_res=3840x2160

# third monitor: 24":
th_res=1920x1080
th_res=1920x1200 # native

script=$(basename $0)

if [ "$script" == "4k.sh" ]; then
  # xrandr --output $main --auto --mode $main_res --dpi $big_dpi --scale-from 1920x1200
  xrandr --output $main --auto --mode $main_res --dpi $big_dpi --transform none
  # 1440 / 1200 = 0.83333
  #xrandr --output $main --auto --mode $main_res --dpi $big_dpi --scale 1x0.833

  sleep 1

  # using auto here will "turn off" the display if the monitor is disconnected:
  #xrandr --output $second --auto --primary
  #xrandr --output $third --auto

  # the display driver can get confused when add/removing displays, so better turn off and on again:
  xrandr --output $second --off --transform none
  xrandr --output $third --off --transform none

  sleep 1

  # but if it's conncted we want to configure it properly:
  # (Machine doesn't support more than 8k horizontal resolution... so turn off main screen)
  # We need to scale the third monitor so the system thinks it has twice as big
  # resolution. Doing this will prevent the interface from being a nice size on
  # the 4k monitor and way too big on the third one.
  # hmm, maybe just mirror the laptop monitor onto third display and scale appropriately?
  # xrandr --output $third --same-as $main --dpi 96 --mode $th_res --auto
  xrandr --output $third --right-of $main --mode $th_res --auto --rotate left
  sleep 0.2
  xrandr --output $second --same-as $main --dpi 96 --mode $sec_res --auto --dpi $big_dpi --primary

elif [ "$script" == "4k-single.sh" ]; then
  xrandr \
    --output $second --off \
    --output $third --off \
    --output $main --auto --mode $main_res --transform none

else
  echo "Unknown script name: \"$script\""
  exit 1
fi

echo Done.

xrandr|grep " con"
