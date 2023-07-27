#!/bin/bash

set -euo pipefail

function help {
    cat <<EOS
This is a utility script that will ask the user for a confirmation before running the command given as arguments.

The command will be run using bash. A preview of the command will be displayed when asking for confirmation.

Usage:

    $0 command [arg1 arg2 ...]

EOS
}

function ask_confirm {
    local input=("$@")
    # There is no easy way to print out the actual command that will be run by
    # bash with the correct escapes intact, but this is pretty close:
    #printf -v cmd '%q ' "${input[@]}"

cat <<EOS
Will run command:

    ${input[@]}

You can CANCEL with ^C (CONTROL+C) now.
Press ENTER to run the command
EOS

    # because of "set -e" cancelling this read will quit the script:
    read -s
}

###############################################################################

number_of_args=$#
if [[ $number_of_args -lt 1 ]]; then
    help
    exit 1
fi

# In order to preserve e.g. multi word arguments we have to first convert to
# array:
cmd_=("$@")
ask_confirm "${cmd_[@]}"
set -x
bash -c "${cmd_[@]}"
