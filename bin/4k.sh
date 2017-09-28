#!/bin/bash

main=${MAIN:-eDP-1}
dell=${VERTICAL:-HDMI-1}
hp=${UWIDE:-DP-2}

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

# dell monitor: physically bigger (27"), so we want this to be primary:
dell_res=1920x1200
dell_res=1920x1080
dell_res=3840x2160

# hp monitor: 24":
hp_res=1920x1080
hp_res=1920x1200 # native

script=$(basename $0)

xrandr -q

if [ "$script" == "4k.sh" ]; then
  if [ "$1" == "fullhd" ]; then
    scale="--scale-from 1920x1080"
    rightof="--pos 1920x0"
    dell_res="1920x1080"
  else
    scale="--transform none"
    scale="--scale-from 2560x1440"
    rightof="--right-of $main"
    rightof="--pos 2560x0"
  fi

  # xrandr --output $main --auto --mode $main_res --dpi $big_dpi --scale-from 1920x1200
  xrandr --output $main --auto --mode $main_res --dpi $big_dpi $scale
  # 1440 / 1200 = 0.83333
  #xrandr --output $main --auto --mode $main_res --dpi $big_dpi --scale 1x0.833

  sleep 1

  # using auto here will "turn off" the display if the monitor is disconnected:
  #xrandr --output $dell --auto --primary
  #xrandr --output $hp --auto

  # the display driver can get confused when add/removing displays, so better turn off and on again:
  xrandr --output $dell --off --transform none
  xrandr --output $hp --off --transform none

  sleep 1

  # but if it's conncted we want to configure it properly:
  # (Machine doesn't support more than 8k horizontal resolution... so turn off main screen)
  # We need to scale the hp monitor so the system thinks it has twice as big
  # resolution. Doing this will prevent the interface from being a nice size on
  # the 4k monitor and way too big on the hp one.
  # hmm, maybe just mirror the laptop monitor onto hp display and scale appropriately?
  # xrandr --output $hp --same-as $main --dpi 96 --mode $hp_res --auto
  xrandr --output $hp $rightof --mode $hp_res --auto --rotate left
  sleep 0.2
  #xrandr --output $dell --same-as $main --dpi 96 --mode $dell_res --auto --dpi $big_dpi --primary
  xrandr --output $dell --same-as $main --dpi 96 --mode $dell_res --auto --dpi $big_dpi --primary $scale

elif [ "$script" == "4k-single.sh" ]; then
  if [ "$1" == "fullhd" ]; then
    scale="--scale-from 1920x1080"
  else
    scale="--transform none"
  fi

  xrandr \
    --output $dell --off \
    --output $hp --off \
    --output $main --auto --mode $main_res $scale

else
  echo "Unknown script name: \"$script\""
  exit 1
fi

echo Done.

xrandr|grep " con"
