#!/bin/bash

set -euo pipefail

confirm_cmd=~/bin/confirm-cmd.sh

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

###############################################################################

number_of_args=$#
if [[ $number_of_args -lt 2 ]]; then
    help
    exit 1
fi

# -i --itemize-changes show how files are changed
# -H --hard-links preserve hard links
#opts="--archive --one-file-system --hard-links --human-readable --verbose --itemize-changes --progress"
#opts="--archive --one-file-system --hard-links --human-readable --verbose --progress"
opts=(--archive --one-file-system --hard-links --specials --human-readable --human-readable --partial --progress --info=stats1,progress2)

# last argument should be destination dir:
dest_dir=$BASH_ARGV

input=("$@")
cmd="mkdir -vp $dest_dir && rsync ${opts[@]} ${input[@]}"

$confirm_cmd "$cmd"
