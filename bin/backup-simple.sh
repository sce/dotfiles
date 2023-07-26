#!/bin/bash

set -euo pipefail

function help {
    cat <<EOS
This script will use rsync to copy given directories to a destination.

Usage:

    $0 [rsync options] source_dir1 [source_dir2 ...] destination_dir

This script will wait for confirmation (pressing ENTER) before continuing.
To use from a script skip the confirmation with e.g.:

    echo | $0 [rsync options] source_dir1 [source_dir2 ...] destination_dir
EOS
}

function ask_confirm {
    local cmd="$1"

cat <<EOS
Will run command:

    $cmd

You can CANCEL with ^C (CONTROL+C) now.
Press ENTER to run the command
EOS

    # because of "set -e" cancelling this read will quit the script:
    read -s
}

###############################################################################

number_of_args=$#
if [[ $number_of_args -lt 2 ]]; then
    help
    exit 1
fi

# -i --itemize-changes show how files are changed
# -H --hard-links preserve hard links
#opts="--archive --one-file-system --hard-links --human-readable --verbose --itemize-changes --progress"
opts="--archive --one-file-system --hard-links --human-readable --verbose --progress"

# last argument should be destination dir:
dest_dir=$BASH_ARGV

cmd="mkdir -vp $dest_dir; rsync $opts $@"

ask_confirm "$cmd"
bash -c "$cmd"
