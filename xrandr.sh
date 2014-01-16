#!/bin/bash

LEFT=VGA1
RIGHT=HDMI1
MODE=1920x1080

CMD="xrandr --output $LEFT --primary --mode $MODE --output $RIGHT --right-of $LEFT --mode $MODE"

echo $CMD
sleep 1

($CMD)
