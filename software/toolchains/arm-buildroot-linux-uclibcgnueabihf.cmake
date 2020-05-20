# Toolchain file for Buildroot toolchain

SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 4.1)

# specify the cross compilers and bin-utils
SET(CMAKE_C_COMPILER $ENV{work}/os/buildroot/output/host/usr/bin/arm-buildroot-linux-uclibcgnueabihf-gcc)
SET(CMAKE_CXX_COMPILER $ENV{work}/os/buildroot/output/host/usr/bin/arm-buildroot-linux-uclibcgnueabihf-g++)

# where is the target environment aka rootfs
SET(CMAKE_FIND_ROOT_PATH $ENV{work}/os/buildroot/output/host/arm-buildroot-linux-uclibcgnueabihf/sysroot)

# search for libraries and headers only in the target cross-compiler directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

MESSAGE( STATUS "CMAKE_C_COMPILER:" ${CMAKE_C_COMPILER})
MESSAGE( STATUS "CMAKE_MAKE_PROGRAM:" ${CMAKE_MAKE_PROGRAM})

