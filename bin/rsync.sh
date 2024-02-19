#!/bin/bash

set -euo pipefail

src=$1
dest=$2
shift 2

# -v --verbose
# -i --itemize-changes - show how files are changed
# -z --compress - compress during transfer
# -H --hard-links - find/transfer hard links
# -x --one-file-system - stay on one file system.
# -n --dry-run

# --progress show progress during transfer
# --link-dest remote directory to hardlink to when file is unmodified
# --exclude-from file with exclude filters

# We use a full datetime timestamp to make sure we can do multiple backups per
# day (for whatever reason) without collisions.
ts=$(date +%Y%m%d-%H%M%S)
log_file="backup-$ts.log"

#opts="--archive --compress --hard-links --one-file-system --log-file=$log_file --progress --human-readable --itemize-changes $@" &&
opts="--archive --compress --hard-links --one-file-system --log-file=$log_file --progress --human-readable --itemize-changes $@" &&

echo "rsync $opts $src $dest >> $log_file" &&
rsync $opts $src $dest
