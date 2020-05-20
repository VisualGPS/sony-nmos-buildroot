#!/bin/bash
# Use this script to transfer the sdcard.img to the sd card. Currently it's hard coded to copy to
# /dev/sdb

# First check if $work has been defined.
if [ -z ${work}  ]
    then 
    echo -e "You must define the \$work environment variable setup before running this script." 
    echo -e "This variable is simply a pointer to the project root directory. For example,"
    echo -e "If your project resides in /home/biff/source/myproj, then \$work would be set"
    echo -e "to /home/biff/source/myproj"
    echo -e "the Script will abort."
    exit 1
fi

# This should point to the buildroot project. We are assuming that buildroot has built the arm
# host tools
BUILDROOT_PROJ=$work/os/buildroot

# Image SD card
echo "Imaging sd card..."
time sudo dd if=$BUILDROOT_PROJ/output/images/sdcard.img of=/dev/sdb bs=64k
echo "Done."

