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

    size=$2

    # Create file with a given size
    dd if=/dev/zero of=./$1 bs=1M count=${size:0:-1}
    # Create filesystem within it
    mkfs.ext4 ./$1
}

mount_fs () {
    check_permissions

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
            create_fs $1 $2
            shift
            shift
        ;;
        mount)
            shift
            mount_fs $1 $2
            shift
            shift
        ;;
        unmount)
            shift
            unmount_fs $1
            shift
        ;;
        format)
            shift
            filename=$1
            create_fs $1 100M # Default size
            mount_fs $1 /mnt/${filename:0:-1}]
            shift
        ;;
    esac
done
