#!/bin/bash
# Builds and creates the sony-nmos image

# Color helpers
CR_RED='\033[1;31m'
CR_GREEN='\033[1;32m'
CR_YELLOW='\033[1;33m'
CR_BLUE='\033[1;34m'
CR_PURPLE='\033[1;35m'
CR_NORMAL='\033[0m' # No Color

# This is prepended to a all echos so you can search for them
TAG_TXT=">>> "
TAG_YELLOW="${CR_YELLOW}${TAG_TXT}${CR_NORMAL}"
TAG_GREEN="${CR_GREEN}${TAG_TXT}${CR_NORMAL}"
TAG_BLUE="${CR_BLUE}${TAG_TXT}${CR_NORMAL}"
TAG_PURPLE="${CR_PURPLE}${TAG_TXT}${CR_NORMAL}"
TAG_ERROR="${CR_RED}${TAG_TXT}[ERROR]:${CR_NORMAL} "
TAG=${TAG_GREEN}

# Check if $work has been defined.
if [ -z ${work}  ]
    then 
    echo -e "${TAG_ERROR} You must define the \$work environment variable setup before running this script." 
    echo -e "${TAG_ERROR} This variable is simply a pointer to the project root directory. For example,"
    echo -e "${TAG_ERROR} If your project resides in /home/biff/source/myproj, then \$work would be set"
    echo -e "${TAG_ERROR} to /home/biff/source/myproj"
    echo -e "${TAG_ERROR} the Script will abort."
    exit 1
fi

# Check if the os as been built (If the OS was built previously, then at least the sdcard.img file should exist)
if [ ! -f $work/os/buildroot/output/images/sdcard.img ]; then
    echo -e "${TAG_ERROR} It appears that OS and files system has not been build."
    echo -e "${TAG_ERROR} Please run ${work}/scripts/build.os script."
    exit 1
fi

# Configure sony-nmos
echo -e "${TAG} Configuring sony-nmos"
$work/scripts/configure-build-arm.sh

# Check result
if [ $? -ne 0 ]; then
    echo -e "${TAG_ERROR} Error - Could not configure sony-nmos"
    exit 1
fi

# Build sony-nmos
cd ${work}/sony-nmosBuild/sony-nmos_release
make -j`cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l`
if [ $? -ne 0 ]; then
    echo -e "${TAGERROR} Build failed."
    exit -1
fi

# Install the sony-nmos executables into our tarket root
echo -e "${TAG} Installing executables..."
TARGET_ROOT_USER=${work}/os/buildroot/rootfs-overlay/root
NMOS_EXEC_SOURCE=${work}/sony-nmosBuild/sony-nmos_release/libs-ext/nmos-cpp/Development
cp ${NMOS_EXEC_SOURCE}/nmos-cpp-node ${TARGET_ROOT_USER}
cp ${NMOS_EXEC_SOURCE}/nmos-cpp-registry ${TARGET_ROOT_USER}
cp ${NMOS_EXEC_SOURCE}/nmos-cpp-test ${TARGET_ROOT_USER}

# Recreate file-system
echo -e "${TAG} Invoking Buildroot to recreate the new disk image..."
cd $work/os/buildroot
# Note: do not use the -j option here, butildroot does this automatically
make
if [ $? -ne 0 ]; then
    echo -e "${TAG_ERROR} Could not recreate the disk image"
    exit -1
fi

echo -e "${TAG} Done. Now you can create your sdcard image."
