#!/bin/sh
awesome --config ~/.config/awesome/rc.lua &
sleep 1

(~/capslock.sh off) & # Map capslock to escape
#(synapse -s) & # it gets activated by gnome

# Do this every time in case it gets changed via an upgrade or something:

  # Still disable the buggy Nautilus desktop thing
  gconftool-2 --type bool --set /apps/nautilus/preferences/show_desktop False

  # sets awesome as wm
  gconftool-2 --type string --set /desktop/gnome/session/required_components/windowmanager awesome

# ck-launch-session is advised for the dbus stuff to work fine.
exec ck-launch-session gnome-session
