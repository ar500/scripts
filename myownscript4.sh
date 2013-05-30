#!/bin/bash

read -p "What is your favorite Operating system?: " os
if [ $os = "linux" ] ; then
 echo "Oh YEAH!"
 exit 0
else
 echo "I said operating system not dog toy."
 exit 0
fi
