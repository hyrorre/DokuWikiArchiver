#!/bin/sh

# config
WIKIPATH="${1:?wiki-path was not specified.}" # path to your wiki, no symbolic links are allowed!
BACKUPPATH="${2:?backup-path was not specified.}" # where do you save the backups?
SAVE_DAYS="${3:-180}" # keep this amount backups

# no more config

# creates $1, if not existant
checkDir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# get date
DATE="`date +%Y%m%d`"

# make sure everything exists
checkDir "${BACKUPPATH}"

# create a backup
tar -czf "${BACKUPPATH}/${DATE}.tgz" -C "${WIKIPATH}" "conf" "data"

# delete old backup(s)
find "${BACKUPPATH}" -type f -mtime +$SAVE_DAYS -exec echo {} \; -exec rm -f {} \;
