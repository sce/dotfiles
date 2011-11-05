#!/bin/sh

## ALT 1:

#awesome --config ~/.config/awesome/rc.lua &
#sleep 1

#(~/capslock.sh off) & # Map capslock to escape
#(synapse -s) & # it gets activated by gnome

# Do this every time in case it gets changed via an upgrade or something:

  # Still disable the buggy Nautilus desktop thing
  #gconftool-2 --type bool --set /apps/nautilus/preferences/show_desktop False

  # sets awesome as wm
  #gconftool-2 --type string --set /desktop/gnome/session/required_components/windowmanager awesome

# ck-launch-session is advised for the dbus stuff to work fine.
#exec ck-launch-session gnome-session

## ALT 2:
gnome-settings-daemon & # themes, screensaver
gnome-power-manager   & # suspend etc.
nm-applet             & # network manager
gnome-volume-manager  & # automounting

synapse -s & # synapse (ctrl+space)
(~/capslock.sh off) & # Map capslock to escape

#eval `gnome-keyring-daemon` # ssh/gpg agent

# for some reason we need to start up nautilus to get background image (and
# desktop icons ...) going.
nautilus &

exec awesome --config ~/.config/awesome/rc.lua
