#!/bin/bash

i3status | while :
do
    read line
    manana=`/home/rkk/bin/manana-i3status.sh`
    echo "$manana | $line" || exit 1
done
