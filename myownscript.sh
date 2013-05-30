#!/bin/bash

# Today is <date> \n You are in <pwd> and your host is <hostname>
# Because I love to show off, get whoami

echo "Today is $(date)"
echo "Hi `whoami`, you are currently in $PWD of $(hostname)"
exit 0
