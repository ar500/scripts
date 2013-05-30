#!/bin/bash

# There are X perameters that include Y. the first is A, the second is B, and the third is C.

USAGE="myownscripts2.sh <parameter> <parameter> <parameter>"

# Check that perameters were actually entered.
if [ $# -ne 3 ] ; then
 echo "This program requires 3 parameters to run"
 echo $USAGE
 exit 1
else 
 PARAM=[$1,$2,$3]
 echo "There are $# parameters that include $PARAM. The first is $1, the second is $2, and the third is $3"
 exit 0
fi
