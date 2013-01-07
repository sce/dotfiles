#!/bin/bash

# http://news.ycombinator.com/item?id=3448266
# https://news.ycombinator.com/item?id=3449414
play -t sl -r48000 -c2 - synth -1 pinknoise tremolo .1 40 <  /dev/zero
