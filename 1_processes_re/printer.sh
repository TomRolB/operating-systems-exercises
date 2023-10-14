#!/bin/bash
if [ -z $1 ] || [ -z $2 ];
then
    echo "Please pass a string and a number as input"
    exit 1
fi

while true;
do
    echo $1
    sleep $2
done