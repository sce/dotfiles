#!/bin/bash

# This script will do an rsync backup of SRC directory to HOST.
# It will place the backup in a timestamp directory in DEST_ROOT and create a
# latest link to that directory when finished.
#
# When run multiple times the latest symlink will be used as --link-dest
# causing new backups to have hardlinked copies of equal files to that of the
# backup before it.
#
# Trailing arguments to this script is passed on to rsync. That's useful for
# passing on e.g. --dry-run.
#
# List of patterns in backup.exclude are excluded from backup.

HOST=
SRC=
EXCLUDE_FROM=backup.exclude
LOG_FILE=backup.log

# We use a full datetime timestamp to make sure we can do multiple backups per
# day (for whatever reason) without collisions.
TS=$(date +%Y%m%d.%H%M%S)

DEST_ROOT=
DEST_DIR=$DEST_ROOT/$TS
LINK_DEST=$DEST_ROOT/latest

DEST=$HOST:$DEST_DIR

[ -z "$HOST" -o -z "$SRC" -o -z "$DEST_ROOT" ] && exit 1

ssh $HOST "[ -d \"$DEST_ROOT\" ] || mkdir -p $DEST_ROOT"

# -a archive
# -h human readable units
# -v verbose
# -i show how files are changed
# -z compress during transfer
# -H find/transfer hard links

# --progress show progress during transfer
# --link-dest remote directory to hardlink to when file is unmodified
# --exclude-from file with exclude filters

OPTS="-ahvizH --progress --log-file=$LOG_FILE --link-dest=$LINK_DEST --exclude-from=$EXCLUDE_FROM $@"

rsync $OPTS $SRC $DEST

# Update link to latest (if trailing --dry-run was given then DEST_DIR won't
# exist, and the link won't be updated).
ssh $HOST "cd $DEST_ROOT && [ -d \"$TS\" ] && ln -snf $TS $LINK_DEST || echo Could not find $DEST_DIR: Not updating latest."
