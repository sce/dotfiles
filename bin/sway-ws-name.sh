#!/bin/bash

#
# This script allows the user to easily rename the current sway workspace via a
# gui prompt. It uses zenity to do so.
#

set -euo pipefail


function get_name {
    name=$(zenity --entry --title="Rename current workspace" --text="Enter new name of current workspace:")
}

function show_error {
    echo "$1"
    zenity --error --title="Failed" --text="$1"
}

function run {
    echo "$1"
    set +e
    error=$($1)

    if [[ $? -eq -0 ]]; then
        error=""
    fi
    set -e
}

get_name

if [[ "$name" == "" ]]; then
    echo "No name given; cancelled."
    exit 1
fi

run "swaymsg --pretty rename workspace to \"$name\""

if [[ "$error" != "" ]]; then
    show_error "$error"
    exit 2
fi
