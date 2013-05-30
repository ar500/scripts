#!/bin/bash

# Backs up all files in current directory modified within the last 24 hours
# in a tarball

BACKUPFILE=backup-$(date +%m-%d-%Y)
#                                Embeds date in backup filename
archive=${1:-$BACKUPFILE}
#   If no backup-archive filename specified on command-line,
#   it will default to "backup-MM-DD-YYYY.tar.gz

find . -mtime -1 -type f -print0 | xargs -0 tar rvf  "$archive.tar"
gzip $archive.tar
echo "Directory $PWD backed up in archive file \"$archive.tar.gz\"."

exit 0
