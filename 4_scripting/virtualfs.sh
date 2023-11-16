#!/bin/bash

check_permissions () {
    if [ $EUID -ne 0 ]; then
        echo "Insufficient permissions. You must execute this command as root."
        exit 1
    fi
}

check_file_exists () {
    if [ -f "$1" ]; then
        echo "Could not format $1: file does not exist."
    fi
}

create_fs () {
    check_permissions

    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: create <.img file> <size>"
        return 1
    fi

    size=$2

    # Create file with a given size
    dd if=/dev/zero of=./$1 bs=1M count=${size:0:-1}
    
}

format_fs () {
    check_permissions

    if [ -z "$1" ]; then
        echo "Usage: format <.img file>"
        return 1
    fi

    check_file_exists "$1"

    # Format file with ext4
    mkfs.ext4 ./$1
}

mount_fs () {
    check_permissions

    check_file_exists "$1"

    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: mount <.img file> <path of mount point>"
        return 1
    fi

    mkdir $2
    mount -o loop $1 $2
}

mount_fs () {
    check_permissions

    if [ -z "$1" ]; then
        echo "Usage: unmount <path of mount point>"
        return 1
    fi

    umount $1
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        create)
            shift
            create_fs "$1" "$2"
            shift
            shift
        ;;
        format)
            shift
            mount_fs "$1"
            shift
        ;;
        mount)
            shift
            mount_fs "$1" "$2"
            shift
            shift
        ;;
        unmount)
            shift
            unmount_fs $1
            shift
        ;;
        *)
        echo "Invalid argument"
        exit 1
        ;;
    esac
done
