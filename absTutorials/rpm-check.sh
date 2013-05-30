#!/bin/bash

#   Queries an rpm file for descriptoin, listing, and whether it can be installed.
#   Saves output to a file

# This script illustrates using a code block

SUCCESS=0
E_NOARGS=65

if [ -z "$1" ]      #   -z =  Is the string 0 bytes?
then
    echo "Usage: `basename $0` rpm-file"
    exit $E_NOARGS
fi

{   #   Begin code block.
    echo
    echo "Archive Description:"
    rpm -qpi $1    #    Query description
    echo
    echo "Archive Listing:"
    rpm - qpl $1    #   Query listing
    echo
    rpm -i --test $1    #   Check if it can be installed
    if [ "$?"   -eq $SUCCESS ]  #   Checks exit status of last command
    then
        echo "$1 can be installed."
    else
        echo "$1 cannot be installed."
    fi
    echo
} > "$1.test"   # Ends code block and redirects output to file

echo "Results of rpm test in file $1.test"

#   See rpm man page for explanation of options.

exit 0
