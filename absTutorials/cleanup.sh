#!/bin/bash

LOG_DIR=/var/log
ROOT_UID=0
LINES=50
E_XCD=86
E_NOTROOT=87
E_WRONGARGS=85 # Non-numerical argument (bad argument format)

# Check UID
if [ "$UID" -ne "$ROOT_UID" ] 
then
    echo "You must be root to run this script."
    exit $E_NOTROOT
fi

# Tutorial method of checking command-line arguments
# I don't like it using a case loop
#if [ -n "$1" ]
# Tests whether command-line argument is present (non-empty)
#then
#    lines=$1
#else
#    lines=$LINES # Default, if not specified on command-line.
#fi

case "$1" in 
    ""        ) 
        lines=$LINES ;;   #   Line argument was not passed
    *[!0-9]*) 
        echo "Usage: `basename $0` Lines-to-cleanup";    #   Regex to test for bad format
        exit $E_WRONGARGS;;
    *           )
        lines=$1;; # If all is well assign the wariable
esac
    
# Efficiant way to ensure directory 
# || == OR   
cd $LOG_DIR || {
    echo "Cannot change to necessary directory." >&2
    exit $E_XCD;
}
 
# Tutorial method for checking directory
# I don't like it....
#if [ "$PWD" != "$LOG_DIR" ]
    # Not in /var/log?
#then
#    echo "Can't change to $LOG_DIR."
#    exit $E_XCD
#fi  # Doublecheck if in right dir before messing with log file.

tail -n $lines messages > mesg.temp     # Saves the last section of message log file.
mv mesg.temp messages                        # Moves last section back to messages.

: > wtmp  
echo "Log files cleaned up"

exit 0 
