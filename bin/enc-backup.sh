#!/bin/bash

# This script will do an rsync backup of SRC directory to HOST. Before doing
# the rsync it will setup a temporary encfs mount with --reverse in order to
# transmit encrypted data only. (Also the config file is transferred in
# plaintext in order to make decryption possible later with only the backup
# available.)
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

HOST=
SRC= # /home/$(whoami)/
# Put the incremental backups inside hostname/user directory:
DEST_ROOT= # /var/backups/$(hostname)/$(whoami).enc

EXCLUDE_FROM=backup.exclude
LOG_FILE=enc-backup.log

[ -z "$HOST" -o -z "$SRC" -o -z "$DEST_ROOT" ] &&
  echo Please edit $0 to setup correctly. &&
  exit 1

# Setup -----------------------------------------------------------------------

# We use a full datetime timestamp to make sure we can do multiple backups per
# day (for whatever reason) without collisions.
TS=$(date +%Y%m%d.%H%M%S)

ENC_DIR=/tmp/$(whoami)-$TS.enc
ENC_CONFIG=$SRC/.encfs6.xml
RSYNC_TMP=$ENC_DIR.rsync-tmp

# The exclude list will only work for exact matches, not exclude patterns.
EXCLUDE_FROM_ENC=backup.exclude.enc

# Where rsync will look for similar files it can hardlink to instead of sending
# over the wire:
LINK_DEST=$DEST_ROOT/latest

# Destination directory has an "incomplete" suffix which we remove after we're
# done.
INCOMPLETE=$TS.incomplete
DEST_DIR=$DEST_ROOT/daily/$INCOMPLETE

DEST=$HOST:$DEST_DIR

# Execution -------------------------------------------------------------------

# Setup reverse encryption (this will create the config file if it doesn't
# already exist):
mkdir -p $ENC_DIR $RSYNC_TMP &&
ENC_CONFIG=$ENC_CONFIG encfs --standard --reverse $SRC $ENC_DIR &&

# Update backup-exclude:
(
  [ "$EXCLUDE_FROM" -nt "$EXCLUDE_FROM_ENC" ] &&
  echo $EXCLUDE_FROM has changed, generating $EXCLUDE_FROM_ENC ... &&
  encfsctl encode $SRC < $EXCLUDE_FROM > $EXCLUDE_FROM_ENC || true
) &&

echo "Destination is: $DEST" &&

ssh $HOST "(
  ([ -d \"$DEST_ROOT/daily\" ] || mkdir -p $DEST_ROOT/daily) &&
  [ -d \"$LINK_DEST\" ] && echo \"Latest backup is: \$(readlink $LINK_DEST)\" || echo \"$LINK_DEST not found: No earlier backup.\" && sleep 3
)" &&

# -a archive
# -h human readable units
# -v verbose
# -i show how files are changed
# -z compress during transfer
# -H find/transfer hard links
# -x stay on one file system.
# -T temporary directory used by rsync during transfer.
#    We need to use -T because it's not possible to create files inside the
#    reverse encrypted mount.
# -s protect args.
#    Let rsync expand e.g. wildcards on the remote host instead of the shell
#    (because the latter could alter the meaning of options passed to rsync).

# --progress show progress during transfer
# --link-dest remote directory to hardlink to when file is unmodified
# --exclude-from file with exclude filters
# --inplace replace files in place. This fixes problems with permissions that
#           for some reason is only happening with the encrypted files.

OPTS="-ahvizHxs -T $RSYNC_TMP --progress --log-file=$LOG_FILE --link-dest=$LINK_DEST --exclude-from=$EXCLUDE_FROM_ENC --inplace $@" &&

# Trailing slash is important:
rsync $OPTS $ENC_DIR/ $DEST &&

# Copy config file too so that we can actually decrypt the backup. (If this was
# a dry run the destination directory will not exist.)
(ssh $HOST "[ -d \"$DEST_DIR\" ]" && scp -p $ENC_CONFIG $DEST || true ) &&

# Update link to latest (if trailing --dry-run was given then DEST_DIR won't
# exist, and the link won't be updated).
ssh $HOST "(
  cd $DEST_ROOT && [ -d \"$DEST_DIR\" ] &&
  mv -iv $DEST_DIR daily/$TS && ln -snfv daily/$TS $LINK_DEST ||
  echo \"Could not find $DEST_DIR: Not updating latest.\"
)" ||

echo "$0: something failed with code $?: Not updating $LINK_DEST."

# Cleanup ---------------------------------------------------------------------

fusermount -u $ENC_DIR
rmdir $ENC_DIR $RSYNC_TMP
