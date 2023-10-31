#!/bin/bash
#TODO: check for permissions

if [ $# -lt 1 ]; then
    echo "You must pass at least one argument. Type './req.sh help' to see the available commands."
    exit 1
fi

txt_path="requirements.txt"

if [ $# -gt 3 ] && { [ "${@: -2:1}" = "-f" ] || [ "${@: -2:1}" = "--file" ]; }; then
    last="${!#}"
    if [[ $last != ./*.txt ]]; then
        echo "Invalid input or text file. The last argument must be of the form ./[text name].txt"
        exit 1
    fi

    txt_path="${last#./}"
    
fi

case "$1" in
    install)
        if [ -d "$txt_path" ]; then
            echo "Could not find txt file in the current directory. Type './req.sh help' to see this command's usage."
            exit 1
        fi

        while read -r "$txt_path"; do
            

        
