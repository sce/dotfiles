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
#gnome-session & # need this in order for everything to work properly ...

#gnome-settings-daemon & # themes, screensaver
#gnome-power-manager   & # suspend etc.
#nm-applet             & # network manager
#gnome-volume-manager  & # automounting
#
#synapse -s & # synapse (ctrl+space)
#(~/capslock.sh off) & # Map capslock to escape

#eval `gnome-keyring-daemon` # ssh/gpg agent

# for some reason we need to start up nautilus to get background image (and
# desktop icons ...) going.
#nautilus &
#
#exec awesome --config ~/.config/awesome/rc.lua

## ALT 3 (for ubuntu 12.04):

#gnome-session & # need this in order for everything to work properly ...

# gnome-settings-daemon & # themes, screensaver
# nm-applet             & # network manager
# dbus-daemon           & # not sure if I need this explicitly
# gnome-keyring-daemon  & # ssh/gpg agent
# bluetoothd            &
# #syndaemon             & # disable touchpad when keyboard is being used
# update-notifier       & # nag about updates
#
# synapse -s & # synapse (ctrl+space)
# (~/capslock.sh off) & # Map capslock to escape
#
# # for some reason we need to start up nautilus to get background image (and
# # desktop icons ...) going.
# nautilus &
#
# exec awesome --config ~/.config/awesome/rc.lua

# exec gnome-session
#exec awesome --config ~/.config/awesome/rc.lua

# 2017-11-07 lets try this:
export GTK_IM_MODULE=xim #Fix for Chrome
export QT_IM_MODULE=xim #Not sure if this works or not, but whatever
export XMODIFIERS=@im=ibus
ibus-daemon -drx

# 2017-08-25 cel: this seems to be needed to prevent slow startup for
# gnome-stuff (due to failing gnome services), see https://bbs.archlinux.org/viewtopic.php?id=224787
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

exec i3
