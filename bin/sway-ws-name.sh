#!/bin/bash

#
# This script allows the user to easily rename the current sway workspace via a
# gui prompt. It uses zenity to do so.
#

set -euo pipefail


function get_name {
    name=$(zenity --entry --title="Rename current workspace" --text="Enter new name of current workspace:")
}

get_name

if [[ "$name" != "" ]]; then
    cmd="swaymsg rename workspace to \"$name\""
    echo $cmd
    $cmd
else
    echo "No name given; cancelled."
fi
