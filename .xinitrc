#!/bin/sh
awesome --config ~/.config/awesome/rc.lua &

(synapse -s) &
(~/capslock.sh off) & # Map capslock to escape

# ck-launch-session is advised for the dbus stuff to work fine.
exec ck-launch-session gnome-session
