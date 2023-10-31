#!/bin/bash
#TODO: check for permissions

if [ $# -lt 1 ]; then
    echo "You must pass at least one argument. Type './req.sh help' to see the available commands."
    exit 1
fi

# Place holder txt file name
txt_path="requirements.txt"

# If a specific txt file name was provided, save it
if [ $# -gt 2 ] && { [ "${@: -2:1}" = "-f" ] || [ "${@: -2:1}" = "--file" ]; }; then
    txt_path="${!#}"
    # last="${!#}"
    # if [[ $last != ./*.txt ]]; then
    #     echo "Invalid input or text file. The last argument must be of the form ./[text name].txt"
    #     exit 1
    # fi

    # txt_path="${last#./}"
    
fi

case "$1" in
    install)
        if [ -d "$txt_path" ]; then
            echo "Could not find txt file in the current directory. Type './req.sh help' to see this command's usage."
            exit 1
        fi
        echo "$txt_path"
        while read -r line; do
            echo "$line"
            if ! dpkg -s "$line";
            then
                if apt-cache policy "$line"; then
                    apt install "$line"
                else
                    echo "WARNING: skipped package $line because it was not found."
                fi
            else
                echo "Package $line was already installed."
            fi
        done < "$txt_path"
    ;;
    *)
        echo "'$1' is not a valid option."
        exit 1
    ;;
esac
            


        
