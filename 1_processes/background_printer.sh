#!/bin/bash

# Handle null arguments
if [ -z $1 ] || [ -z $2 ]; then
   echo "Error: arguments missing. Pass two integer values."
   exit 1
fi

./printer.sh $1 $2 &
pid=$!
renice 19 -p $pid

echo "PID of printer.sh is $pid"
sleep 20
renice -n 5 -p $pid

echo "Hit enter to stop"

while [ true ]
do
    read -n 1 -s KEY
    if [ -z $KEY ]; then
    	kill $pid
	exit 0
    fi
done

