#!/bin/bash

# This script will hardlink the latest file in daily to weekly/monthly/yearly
# directory, depending on action given. In addition it will delete old backups
# from directory belonging to target action.
#
# Put this in cron, e.g.:
#
#   BACKUP_SCRIPT=rotate_backups.sh
#   BACKUP_DIR=/var/backups/sql
#
#   0 23 * * *   $BACKUP_SCRIPT $BACKUP_DIR daily
#   0 23 * * sun $BACKUP_SCRIPT $BACKUP_DIR weekly
#   0 23 1 * *   $BACKUP_SCRIPT $BACKUP_DIR monthly
#   0 23 1 1 *   $BACKUP_SCRIPT $BACKUP_DIR yearly
#
#   # The only extra step needed is something like this:
#   0 0 * * * create_backup.sh > $BACKUP_DIR/daily

BACKUP_BASE=$1
ACTION=$2
[ -z "$BACKUP_BASE" ] && echo "Supply backups base dir as first argument." && exit 1

[ "setup" == "$ACTION" ] && (
  mkdir -pv $BACKUP_BASE/{daily,weekly,monthly,yearly} && echo || exit 1
) && exit 0

# Safety for existing directory:
if [ ! -d "$BACKUP_BASE/daily" -o ! -d "$BACKUP_BASE/weekly" -o ! -d "$BACKUP_BASE/monthly" -o ! -d "$BACKUP_BASE/yearly" ]; then
  echo "Doesn't look like \"$BACKUP_BASE\" is setup correctly, quitting."
  exit 1
fi

# Array of current daily backups. First index is latest.
LATEST=( $(ls -t $BACKUP_BASE/daily/* 2>/dev/null) )

case $ACTION in
  daily)
    # Always keep the last daily backup lying around. This ensures that any
    # symlink to the latest backup always works and that non-daily rotations
    # always work.
    CANDIDATES="${LATEST[*]:1}"
    [ -n "$CANDIDATES" ] && find $CANDIDATES -mtime +7 -exec rm -rf {} +
    ;;

  weekly)
    [ -n "$LATEST" ] && cp -al $LATEST $BACKUP_BASE/weekly/
    find $BACKUP_BASE/weekly -maxdepth 1 -mtime +31 -exec rm -rf {} +
    ;;

  monthly)
    [ -n "$LATEST" ] && cp -al $LATEST $BACKUP_BASE/monthly/
    find $BACKUP_BASE/monthly -maxdepth 1 -mtime +365 -exec rm -rf {} +
    ;;

  yearly)
    [ -n "$LATEST" ] && cp -al $LATEST $BACKUP_BASE/yearly/
    ;;

  *)
    echo "Usage: $0 <backups_base_dir> <setup|daily|weekly|monthly|yearly>"
    ;;
esac
