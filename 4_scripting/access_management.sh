#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "You must have root permissions to execute this script."
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        grant- | revoke-)
            aux=$1
            operation="+"
            permission=${aux:6:7}
            
            shift
            who=$1
            if id "$who" &>/dev/null; then
                type="u"
            elif grep -q "$who" /etc/group; then
                type="g"
            else
                echo "Expected a user or a group; got '$who'"
                exit 1
            fi
            
            shift
            path=$1
            if [ ! -f "$path" ] || [ ! -d "$path" ]; then
                echo "Expected a file or directory path; got '$path'"
            fi

            chmod "$type""$operation""$permission" "$who" "$path"

