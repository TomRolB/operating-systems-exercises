#!/bin/bash

check_permissions () {
    if [ $EUID -ne 0 ]; then
        echo "Insufficient permissions. You must execute this command as root."
        exit 1
    fi
}

create_fs () {
    check_permissions

    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: create <.img file> <size>"
        return 1
    fi

    mke2fs -t ext4
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        create)
            shift
            create_fs $1 $2
            shift
            shift
        ;;