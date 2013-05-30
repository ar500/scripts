#!/bin/bash

# A routine that tests whether the script has 
# been invoked with the correct number of parameters

# Usage:
#   Number of required args should be passed defined with reqargs variable
#   Accepted parameters should be passed with scriptpar variable

E_WRONG_ARGS=85

if [ $# - ne $reqargs ]
then
    echo "Usage: `basename $0` $scriptpar"
    # `basename $0 is the scripts filename
    exit $E_WRONG_ARGS
fi
