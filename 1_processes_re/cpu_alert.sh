#!/bin/bash

accum=0
top | while read -r line; do
    set -- $line
    accum=$((accum+$8))
done

if [ $accum -gt 80 ]; then
    echo "WARNING: CPU usage over 80%"
else
    echo "CPU usage is below 80%"
fi