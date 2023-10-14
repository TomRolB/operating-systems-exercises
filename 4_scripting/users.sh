#!/bin/bash
if [ $# -lt 2 ]; then
    echo "Invalid arguments"
    exit 1
fi

if [ "$1" == "--add-user" ]; then
    if [ $# -gt 2 ]; then
        echo "Invalid arguments. To add an user, please input a command of the form --add-user username"
        exit 1
    fi

    sudo adduser "$2"
    exit 0
fi

if [ "$1" = "--user" ]; then
    if [ "$2" =  "--delete-user" ]; then
        if [ -z "$3" ]; then
            echo "Expected username, but got no argument instead"
            exit 1
        fi

        if [ $# -gt 2 ]; then
            echo "Too many arguments. Required username only."
            exit 1
        fi

        if [ "$3" = -* ]; then
            echo "Expected username, but got an option or an argument with a dash instead: $3"
            exit 1
        fi

        sudo deluser --remove-home "$3"
        exit 0
    fi



    # Iterate over the arguments and save them to variables.
    # This is done to avoid starting execution and only afterwards
    # realizing there were invalid arguments.

    groupnamesToAdd=()
    changingPassword=false # Make sure password is trying to be changed only once
    groupnamesToRemove=()

    i=2
    while [ i -le $# ]; do
        case "${!i}" in

        --delete-user)
            echo "Invalid argument: option --delete-user must be used in isolation"
            exit 1
        ;;

        --add-to-group)
            ((i++))
            groupname="${!i}"

            if [ -z "$groupname" ]; then
                echo "Expected groupname, but got no argument instead"
                exit 1
            fi

            if [ "$groupname" = -* ]; then
                echo "Expected groupname, but got an option or an argument with a dash instead: $3"
                exit 1
            fi

            groupnamesToAdd+="$groupname"
        ;;

        --remove-from-group)
            ((i++))
            groupname="${!i}"

            if [ -z "$groupname" ]; then
                echo "Expected groupname, but got no argument instead"
                exit 1
            fi

            if [ "$groupname" = -* ]; then
                echo "Expected groupname, but got an option or an argument with a dash instead: $3"
                exit 1
            fi

            groupnamesToRemove+="$groupname"
        ;;

        --change-password)
            if [ $changingPassword ]; then
                echo "Password can only be changed once in the same call"
                exit 1
            fi

            changingPassword=true
        ;;
        esac

        ((i++))
    done

    # Begin command execution per se









        


    