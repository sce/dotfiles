#!/bin/bash

# Still disable the buggy Nautilus desktop thing
gconftool-2 --type bool --set /apps/nautilus/preferences/show_desktop False

# sets awesome as wm
gconftool-2 --type string --set /desktop/gnome/session/required_components/windowmanager awesome
