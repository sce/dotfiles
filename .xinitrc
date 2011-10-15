#!/bin/sh
awesome --config ~/.config/awesome/rc.lua &
sleep 1

(~/capslock.sh off) & # Map capslock to escape
#(synapse -s) & # it gets activated by gnome

# ck-launch-session is advised for the dbus stuff to work fine.
exec ck-launch-session gnome-session
