#!/bin/bash
pid=$(lsof -ti tcp:"$1")
if [ -n "$pid" ]; then
    echo "$pid"
    read -rsn1 key
    if [ "$key" == "" ]; then
        kill "$pid"
    fi
fi
