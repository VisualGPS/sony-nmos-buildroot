#!/bin/bash
# This script will build the boot-loader, Linux OS, make patches and build the applications.
# To bypass all yes/no questions with all "yes", use parameter yes. ie create-dev-env yes

# Check if $work has been defined.
if [ -z ${work}  ]
    then 
    echo -e "You must define the \$work environment variable setup before running this script." 
    echo -e "This variable is simply a pointer to the project root directory. For example,"
    echo -e "If your project resides in /home/biff/source/myproj, then \$work would be set"
    echo -e "to /home/biff/source/myproj"
    echo -e "the Script will abort."
    exit 1
fi

# Our message tag
TAG="\033[0;32m>>>\e[0m"

# Check if the first parameter is "yes" and set the autoYes variable
autoYes="no"
if [ -z "$1" ]; then
    autoYes="no"
else
    autoYes=$1
    echo $1
fi

#
# Let the user know whats about to happen
#
user_input="no"
if [ "${autoYes}" == "yes" ]; then
    user_input="yes"
else
    echo -e "${TAG} Run this script to setup the development environment, build the bootloaders, build the OS, and download external libraries." 
    read -p "Do you want to continue? (yes/[no]):" user_input
fi
if [ "${user_input}" != "yes" ]; then
    echo -e "Aborting."
    exit 1
fi

#
# Create the buildroot environment
#

# Build the bootloaders
echo -e "${TAG} Building bootloades..."
cd $work/os/boot
./rebuild.sh

# Delete old buildroot directory
echo -e "${TAG} Deleting old buildroot directory..."
rm -rf $work/os/buildroot

# Retrieving buildroot
echo -e "${TAG} Cloning buildroot..."
# Get buildroot
echo -e "${TAG} Cloning buildroot from git.buildroot.net..."
cd $work/os
git clone git://git.buildroot.net/buildroot

cd $work/os/buildroot
# Checkout specific version
BUILDROOT_TAG=2020.05-rc1
echo -e "${TAG} Checkout tag ${BUILDROOT_TAG}..."
git checkout ${BUILDROOT_TAG}

# Copy our patches
echo -e "${TAG} Copy Cobalt patches..."
cp -r $work/os/patches/buildroot/* $work/os/buildroot/

# Apply patches to buildroot itself
# Setup the ground hog environment
echo -e "${TAG} Setup buildroot to use the groundhog board..."
cd $work/os/buildroot
make sony_nmos_rpi3_defconfig

# Build the OS
echo -e "${TAG} Building buildroot..."
cd $work/os/buildroot
# Note: do not use the -j option here, butildroot does this automatically
make
cd $work

echo -e "${TAG} Done."



