# sony-nmos-buildroot (nmos-cpp)

## Table of Contents

- [Introduction](#introduction)
- [The `work` Environment Variable](#the-work-environment-variable)
- [Dependencies](#dependencies)
- [Build](#build)
- [Running](#running)
- [Scripts](#scripts)

## Introduction

This project is to demonstrate the Sony [nmos-cpp](https://github.com/sony/nmos-cpp) (Networked Media Open Specifications) using Buildroot and the Raspberry Pi. The project has only two scripts to run. The first will download buildroot, configure, and build the Linux kernel and associated root file system. The second will configure, build, and install the nmos-cpp node and registry examples.

## The `work` Environment Variable

The project does require one environment variable defined, '`work`'. This variable simply points to the root directory for this project. For example, if the project is located in `~/Source/sony-nmos-buildoot`, then export would look like:

```bash
export work=/home/someuser/Source/sony-nmos-buildroot
```

## Dependencies

- git
- c/c++ (build essentials)
- cmake

## Build

This project is built using scripts or you can build it manually. 

### Build Linux Kernel, File System, and Sony NMOS

- run $work/scripts/build-os.sh
- run $work/scripts/make-release.sh
- Burn an SD card from `$work/os/buildroot/output/images/sdcard.img` and insert into the Raspberry Pi.

## Burning an SD Card

Use the dd command to burn the image to the SD card. Below is an example of burning the SD image assuming your SD card is located at `/dev/sdb`.

```bash
sudo dd if=$work/os/buildroot/output/images/sdcard.img of=/dev/sdb bs=64k
```

## Running

The default login for the target is root and the password is raspberry. There should be three executable files located in `/root`

```bash
[root@sony-nmos ~]$ ls -l
total 16029
-rwxr-xr-x    1 root     root       6727884 May 21 20:04 nmos-cpp-node
-rwxr-xr-x    1 root     root       5956884 May 21 20:04 nmos-cpp-registry
-rwxr-xr-x    1 root     root       3729996 May 21 20:04 nmos-cpp-test
[root@sony-nmos ~]$ 
```

Follow the instruction from the sony nmos-cpp GitHub repository.

## Scripts

- `build-os.sh` This script will download Buildroot, copy patches that are specific to this project, configure Buildroot, and then build the OS and file system.
- `make-release.sh` - This script will configure the nmos-cpp using CMake and, build the libraries, install the executable to the `rootfs-overlay` directory, and finally rebuild the file system disk image. Please note that this scripts will initialize and update any git submodules.

### Helper Scripts

- `configure-build-arm.sh` This script will create the `$work/sony-nmosBuild` directory, run CMake with the appropriate tool-chain to configure the nmos-cpp library. This script is called from the `make-release.sh ` script.
- `copy-sdcard-image-to-sdb.sh` This is a simple utility that will image an sd card with the `$work/os/buildroot/output/images/sdcard.img` file. It assumes that the sd card is `/dev/sdb`.
