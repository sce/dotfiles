#!/bin/sh
# From http://www.linuxquestions.org/questions/linux-general-1/vim-map-caps-lock-to-escape-409726/

case $1 in
  off)
    xmodmap -e "clear lock"
    xmodmap -e "keycode 0x42 = Escape"
    ;;
  on)
    xmodmap -e "keycode 0x42 = Caps_Lock"
    xmodmap -e "add lock = Caps_Lock"
    ;;
  *)
    echo "Usage: caps {on|off}, turn the caps lock key on or"
    echo "off.  When it is off, the key acts as an Escape key."
    ;;
esac
