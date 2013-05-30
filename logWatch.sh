#!/bin/bash

# A script used to watch files and mail a user when something is fishy...

# Define variables.
uid=$UID
USAGE="./logWatch.sh <filename>"

# Check if process was run as root...

if [ $uid -gt 0 ] ; then
 echo $USAGE ; exit 1
elif [ $# -lt 1 ] ; then
 echo $USAGE ; exit 1
elif [ ! -f  $1 ] ; then
 echo $USAGE ; exit 1
else
 tail -f -n 3
 exit 0
fi
   
