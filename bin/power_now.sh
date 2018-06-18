#!/bin/bash
# from https://unix.stackexchange.com/questions/10418/how-to-find-power-draw-in-watts

bat=${BAT-BAT0}

current=$(cat /sys/class/power_supply/$bat/current_now)
voltage=$(cat /sys/class/power_supply/$bat/voltage_now)
micro=1000000000000

echo - | awk "{ printf \"%.1f\n\", $(( $current * $voltage )) / $micro }"
