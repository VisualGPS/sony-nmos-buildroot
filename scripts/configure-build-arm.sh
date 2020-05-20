#!/bin/bash
#
# Script to configure the application project for a build. $work must be defined.
#

# Check if $work has been defined.
if [ -z ${work}  ]
    then 
    echo -e "${TAGERROR} You must define the \$work environment variable setup before running this script." 
    echo -e "${TAGERROR} This variable is simply a pointer to the project root directory. For example,"
    echo -e "${TAGERROR} If your project resides in /home/biff/source/myproj, then \$work would be set"
    echo -e "${TAGERROR} to /home/biff/source/myproj"
    echo -e "${TAGERROR} the Script will abort."
    exit 1
fi

#
# Defines the script setup
#
PROJ_NAME="reg-manager"
BUILD_DIR=${work}/${PROJ_NAME}Build
SEARCH_DIR=${work}/software/source
# glibc reference to toolchain
TOOL_CHAIN="${work}/software/toolchains/arm-buildroot-linux-gnueabihf.cmake"
TOOL_CHAIN_SW="-DCMAKE_TOOLCHAIN_FILE=${TOOL_CHAIN}"

# Color helpers
CR_RED='\033[1;31m'
CR_GREEN='\033[1;32m'
CR_YELLOW='\033[1;33m'
CR_BLUE='\033[1;34m'
CR_PURPLE='\033[1;35m'
CR_NORMAL='\033[0m' # No Color

# This is prepended to a all echos so you can search for them
TAG=">>> "
TAG_YELLOW="${CR_YELLOW}${TAG}${CR_NORMAL}"
TAG_GREEN="${CR_GREEN}${TAG}${CR_NORMAL}"
TAG_BLUE="${CR_BLUE}${TAG}${CR_NORMAL}"
TAG_PURPLE="${CR_PURPLE}${TAG}${CR_NORMAL}"
TAG_ERR="${CR_RED}${TAG}[ERROR]:${CR_NORMAL} "

#
# Make sure we get our submodules
#
echo -e "${TAG_GREEN}Updating submodules"
git submodule init
git submodule update --recursive

#
# Define release, debug builds and create directories
#
RELEASE_DIR="${BUILD_DIR}/${PROJ_NAME}_release"
DEBUG_DIR="${BUILD_DIR}/${PROJ_NAME}_debug"

if [ -d ${RELEASE_DIR} ]; then 
    echo -e "${TAG_YELLOW}Forcing deleting of ${RELEASE_DIR} directory..."
    rm -rf ${RELEASE_DIR}
fi

# Build directory
if [ ! -d ${BUILD_DIR} ]; then
    echo -e "${TAG_YELLOW}Creating ${BUILD_DIR} directory..."
    mkdir ${BUILD_DIR}
fi
# Release directory
if [ ! -d ${RELEASE_DIR} ]; then
    echo -e "${TAG_YELLOW}Creating ${RELEASE_DIR} directory..."
    mkdir ${RELEASE_DIR}
fi
# Debug directory
if [ ! -d ${DEBUG_DIR} ]; then
    echo -e "${TAG_YELLOW}Creating ${DEBUG_DIR} directory..."
    mkdir ${DEBUG_DIR}
fi

#
# Run cmake and configure for eclipse and generate build file for the project
#
# -DCMAKE_EXE_LINKER_FLAGS_INIT="-L ${RPI_LIBS}/lib -L ${SYSROOT} -Wl,-rpath-link=${SYSROOT}:${OPENSSL_LIB_DIR}:${RPI_LIBS}/lib -latomic"
CMAKE_COMMON=`-G"Eclipse CDT4 - Unix Makefiles" -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON`

# Debug config
# echo -e "${TAG_GREEN}Running cmake for debug configuration..."
# cd ${BUILD_DIR}/${PROJ_NAME}_debug
# cmake ${CMAKE_COMMON} -DCMAKE_BUILD_TYPE=Debug ${SEARCH_DIR} ${TOOL_CHAIN_SW}
# echo -e "${TAG_GREEN}Running cmake for release configuration..."

# Releasee config
cd ${BUILD_DIR}/${PROJ_NAME}_release
# My attempt to fix the OpenSSL link error
LIBROOT=${work}/os/buildroot/output/build
#OPENSSL_LIB_DIR=${LIBROOT}/libopenssl-1.1.1g
OPENSSL_LIB_DIR=${work}/os/buildroot/output/host/arm-buildroot-linux-gnueabihf/sysroot/usr/lib

#OPENSSL_LINK=-DCMAKE_EXE_LINKER_FLAGS_INIT="-L ${LIBROOT} -Wl,-rpath-link=${OPENSSL_LIB_DIR} -latomic"
cmake ${CMAKE_COMMON} -DCMAKE_BUILD_TYPE=Release -DUSE_CONAN:BOOL="0" ${SEARCH_DIR} ${TOOL_CHAIN_SW} -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_EXE_LINKER_FLAGS_INIT="-L ${LIBROOT} -Wl,-rpath-link=${OPENSSL_LIB_DIR} -latomic"


#cmake ${CMAKE_COMMON} -DCMAKE_BUILD_TYPE=Release -DUSE_CONAN:BOOL="0" ${SEARCH_DIR} ${TOOL_CHAIN_SW} -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

echo -e "${TAG_GREEN}Done."
echo -e "${TAG_GREEN}${BUILD_DIR} can be used as your eclipse workspace."
echo -e "${TAG_GREEN}You also cd into ${RELEASE_DIR}"
echo -e "${TAG_GREEN}or ${DEBUG_DIR}"
echo -e "${TAG_GREEN}and perform a make."
