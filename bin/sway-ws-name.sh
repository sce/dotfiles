#!/bin/bash

#
# This script allows the user to easily rename the current sway workspace via a
# gui prompt. It uses zenity to do so.
#

set -euo pipefail

set -x

ask=,zenity

function get_name {
    name=$($ask --entry --title="Rename current workspace" --text="Enter new name of current workspace:" --ok-label="Rename")
}

function get_name_error {
    local msg=$1
    name=$($ask --entry --title="Rename current workspace" --text="$msg\n\nEnter new name of current workspace:" --ok-label="Rename")
}


function show_error {
    echo "$1"
    $ask --error --title="Failed" --text="$1"
}

function run {
    echo "$1"
    set +e
    error=$($1)

    if [[ $? -eq -0 ]]; then
        error=""
    else
        >&2 echo "$error"
    fi
    set -e
}

function run_rename {
    local name="$1"
    run "swaymsg --pretty rename workspace to \"$name\""
}

################################################################################

get_name

if [[ "$name" == "" ]]; then
    echo "No name given; cancelled."
    exit 1
fi

run_rename "$name"

# continue retrying until we are successful or the user quits:
while [[ "$error" != "" ]]; do
    #show_error "$error"
    get_name_error "$error"
    if [[ "$name" == "" ]]; then
        echo "No name given; cancelled."
        exit 1
    fi
    run_rename "$name"
done
