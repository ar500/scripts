#!/bin/bash

# Reading lines in /etc/fstab

File=/etc/fstab

{
read line1
read line2
}

echo "First line in $File is:"
echo "$line1'\n'"
echo "Second line in $File is:"
echo "$line2'\n'"

exit 0
