#!/bin/bash

modify_access () {
    who=$1
    if id "$who" &>/dev/null; then
        type="u"
    elif grep -q "$who" /etc/group; then
        type="g"
    else
        echo "Expected an user or a group; got '$who'"
        exit 1
    fi
    
    shift
    path=$1
    if [ ! -f "$path" ] || [ ! -d "$path" ]; then
        echo "Expected an existing file or directory path; got '$path'"
    fi

    chmod "$type""$operation""$permission" "$who" "$path"
}

if [ $EUID -ne 0 ]; then
    echo "You must have root permissions to execute this script."
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        grant-) 
            aux=$1

            if [ ${aux:6:} != "read" ]; then
                permission="r"
            elif [ ${aux:6:} != "write" ]; then
                permission="w"
            else
                echo "Expected 'read' or 'write' permission; got '${aux:6:7}'"
            fi
            
            shift
            args=$@
            modify_access "+" "$permission" $args
        ;;
        revoke-)
            aux=$1

            if [ ${aux:6:} != "read" ]; then
                permission="r"
            elif [ ${aux:6:} != "write" ]; then
                permission="w"
            else
                echo "Expected 'read' or 'write' permission; got '${aux:6:7}'"
            fi
            
            shift
            args=$@
            modify_access "-" "$permission" $args
        ;;
        list-permissions)
            shift
            if [ ! -d "$1" ] || [ ! -f "$1" ]; then
                echo "Expected an existing file or directory path; got '$path'"
            fi
        ;;
        *)
            echo "Invalid argument. Usage:"
        ;;
    esac
done