#!/bin/bash
# Runs a loop in the background

for i in {1..10}    # First loop
do
    echo -n "$i "; sleep 1
done &                  # Runs this loop in bg
    
echo    # This echo will sometimes not display

for i in {11..20}   # second loop
do
    echo -n "$i "; sleep 1
done

echo    # This echo will sometimes not display

#===============================================

#   The expected output from the script
#   1 2 3 4 5 6 7 8 9 10
# 11 12 13 14 15 16 17 18 19 20

# Sometimes. though you get:
# 11 12 13 14 15 16 17 18 19 20
# 1 2 3 4 5 6 7 8 9 10
# why?
# Because both loops are set to run simultaniously, to get the script to count you must
# cause the second loop to run only after the first has finished with the "wait" cmd

