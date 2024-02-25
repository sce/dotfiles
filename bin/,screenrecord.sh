#!/bin/bash

set -euo pipefail

# https://linuxconfig.org/how-to-propagate-a-signal-to-child-processes-from-a-bash-script
#
# We trap SIGINT and SIGTERM and then send SIGINT to everything in this process
# group (kill 0) which will cause the recording to gracefully exit.
#
# Because this script is also part of the process group we have to first
# redefine the trap handler to nothing before executing it.
trap 'trap " " SIGINT SIGTERM; kill -SIGINT 0; wait' SIGINT SIGTERM

ask=~/bin/,zenity

function wait_for_user_ok {
    name=$($ask --info --title="Recording current output" --text="Recording continues until it is stopped." --ok-label="Stop recording")
}

~/bin/screenrecord.sway &

wait_for_user_ok
kill -s SIGINT 0
wait
