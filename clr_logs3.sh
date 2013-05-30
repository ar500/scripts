#!/bin/bash
# Cleanup version 3

LOG_UID=0	# Only root users with $UID 0 may proceed
LINES=50	# Default number of lines saved
E_XCD=86	# Can't change directory?
E_NOTROOT=87	# Non-root exit error.
E_WRONGARGS=85

if [ "$UID" -ne "$ROOT_UID" ]
then
 echo "You must be root to run this script."
 exit $E_NOTROOT
fi

if [ -n "$1" ]
then
 lines=$1
else
 lines=$LINES
fi

cd $LOG_DIR
if [ 'pwd' != "$LOG_DIR" ]
then
 echo "Can't change to $LOG_DIR."
 exit $e_XCD
fi

tail -n $lines messages > mesg.temp
mv mesg.temp messages

cat /dev/null > wtmp 
echo "Log files cleaned up"

exit 0
