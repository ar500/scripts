#!/usr/bin/env bash
# mountre.sh

# Script to mount a local share..

# Global Variables
REM_USER_DEFAULT="$SUDO_USER"
LOC_PATH_DEFAULT="/home/ar500/Desktop/Share"
SVR_IP_DEFAULT="192.168.0.20"
SHARE_DEFAULT="/external"
USAGE="`basename $0` [-u <user>][-m <mount point>] -H <server> -s <share>"  
ROOT_UID=0
E_NOTROOT=87
OPTIND=1 # Ensure getopts is reset.

while getopts "h?:u:m:H:s:" opt; do
    case "$opt" in
    h|\?)
        echo $USAGE
        exit 0
        ;;
    u)
        REM_USER=$OPTARG
        ;;
    m)
        LOC_PATH=$OPTARG
        ;;
    H)
        SVR_IP=$OPTARG
        ;;
    s)
        SHARE=$OPTARG
        ;;
    *)
        echo "unreconized option"
        echo "$USAGE"
    esac
done

# Set default variables if undefined by user
: ${REM_USER=$REM_USER_DEFAULT}
: ${LOC_PATH=$LOC_PATH_DEFAULT}
: ${SVR_IP=SRV_IP_DEFAULT}
: ${SHARE=SHARE_DEFAULT}

# Functions

function VALID_DIR() {
    # Checks if passed dir is a dir and is writable returns 0 or 1 
    #VALID_DIR $LOC_PATH
    if [ ! -d $1 ] ; then
        echo "$1 is not a valid directory" >&2
        return 1
    elif [ ! -w $1 ] ; then  
        echo "The current user does not have write privlages for $1"
        echo "Are you sure you want to mount the share in $1? [y/n]: "
        read confirm
        if [ $(confirm | tr  '[A-Z]' '[a-z]') = "n" ] ; then
            echo "Please select a valid directory" >&amp:2
            return 1
        else
        return 0
        fi
    fi
}

function IS_IP() {
    # checks the format of the server address
    # #IS_IP $SRV_ADDRESS
    local ip=$1
    local stat=1
    
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$  ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

function IS_UP() {
    # This function checks if the server is alive
    # this function may fail, would be better to use nmap, but for portability I'm keeping it
    ping -vvv -c 1 $1 > /dev/null >&1
}

function IS_MOUNTED() {
    mount | grep $1 > /dev/null >&1
}
    
    
#Sanity checks
if [  $UID -ne $ROOT_UID ] ; then # Not root
    echo "This script requires root privlages" >&2 
    exit $E_NOTROOT
fi

VALID_DIR $LOC_PATH
if [  $? -eq 1 ] ; then # Path is not valid
    echo $USAGE
    exit 1
fi

IS_IP $SVR_IP
if [ $? -eq 1 ] ; then # User passed invalid address
    echo "Please enter a vaild address"
    echo $USAGE
    exit 1
fi

IS_UP $SVR_IP
wait
if [ $? -eq 1 ]; then # Server is down or doesn't respond to pings
    echo "The server is down, please check the server and try again"
    exit 1
fi

IS_MOUNTED $LOC_PATH
if [ $? -eq 0 ]; then
    echo "Please provide a different mount point"
    exit 1
fi



# All is well, time to mount the server
mount -t cifs $REM_PATH  $LOC_PATH -o user=$REM_USER > /dev/null >&1
if [ $? -eq 1 ]; then
    echo "Mount Failed"
    exit 1
else 
    echo "$REM_PATH was mounted on $LOC_PATH"
    exit 0
fi


