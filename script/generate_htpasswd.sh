#!/bin/sh
if [ -z "$1" ]
  then
    echo "Specify a username to use this script"
    exit 1
fi

echo "Use a strong, long password; otherwise, this is all a waste of time"
htpasswd -nB -C 10 $1 
