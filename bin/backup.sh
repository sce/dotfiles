#!/bin/bash

# This script will do an rsync backup of SRC directory to HOST.
# If host is unset, this will be a local backup.
#
# It will place the backup in a timestamp directory in DEST_ROOT and create a
# latest link to that directory when finished. The destination directory has an
# "incomplete" suffix which is removed after rsync-ing is done.
#
# When run multiple times the latest symlink will be used as --link-dest
# causing new backups to have hardlinked copies of equal files to that of the
# backup before it.
#
# Trailing arguments to this script is passed on to rsync. That's useful for
# passing on e.g. --dry-run.
#
# List of patterns in backup.exclude are excluded from backup.

#: ${HOST=default_host}
#: ${SRC:=/home/$(whoami)/}

# Put the incremental backups inside hostname/user directory:
#: ${DEST_ROOT:=/var/backups/$(hostname)/$(whoami)}

# The work dir is the root directory from where this script expects to find
# config, place logs etc.
WORK_DIR=~

EXCLUDE_FROM=$WORK_DIR/.config/backup.exclude

[ -z "$SRC" -o -z "$DEST_ROOT" ] && exit 1
[ -z "$HOST" ] && echo "HOST is unset, this will be a local backup..."

# Setup -----------------------------------------------------------------------

# We use a full datetime timestamp to make sure we can do multiple backups per
# day (for whatever reason) without collisions.
TS=$(date +%Y%m%d.%H%M%S)

LOG_FILE=$WORK_DIR/.local/log/backup-$TS.log

# Where rsync will look for similar files it can hardlink to instead of sending
# over the wire:
LINK_DEST=$DEST_ROOT/latest

# Destination directory has an "incomplete" suffix which we remove after we're
# done.
INCOMPLETE=$TS.incomplete
DEST_DIR=$DEST_ROOT/$INCOMPLETE

if [ -z "$HOST" ]; then
  DEST=$DEST_DIR
else
  DEST=$HOST:$DEST_DIR
fi

# Execution -------------------------------------------------------------------

mkdir -vp $(dirname $LOG_FILE) || exit 1

cmds=$(cat <<EOS
  ([ -d "$DEST_ROOT" ] || mkdir -p $DEST_ROOT) &&
  [ -d "$LINK_DEST" ] && echo "Latest backup is: \$(readlink $LINK_DEST)" || true
EOS
)

if [ -z "$HOST" ]; then
  bash -c "${cmds}"
else
  ssh $HOST "($cmds)"
fi &&

sleep 3 &&

# -a archive
# -h human readable units
# -v verbose
# -i show how files are changed
# -z compress during transfer
# -H find/transfer hard links
# -x stay on one file system.

# --progress show progress during transfer
# --link-dest remote directory to hardlink to when file is unmodified
# --exclude-from file with exclude filters

#OPTS="-ahvizHx --progress --log-file=$LOG_FILE --link-dest=$LINK_DEST --exclude-from=$EXCLUDE_FROM $@" &&
OPTS="-ahizHx --progress --log-file=$LOG_FILE --link-dest=$LINK_DEST --exclude-from=$EXCLUDE_FROM $@" &&

echo rsync $OPTS $SRC $DEST >> $LOG_FILE &&
rsync $OPTS $SRC $DEST &&

# Update link to latest (if trailing --dry-run was given then DEST_DIR won't
# exist, and the link won't be updated).
cmds=$(cat <<EOS
  cd $DEST_ROOT && [ -d "$INCOMPLETE" ] &&
  mv -iv $INCOMPLETE $TS && ln -snfv $TS $LINK_DEST ||
  echo "Could not find $DEST_DIR: Not updating latest."
EOS
)

if [ -z "$HOST" ]; then
  bash -c "${cmds}"
else
  ssh $HOST "($cmds)"
fi ||
echo "$0: something failed with code $?: Not updating $LINK_DEST."
