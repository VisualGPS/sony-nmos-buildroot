# sony-nmos-buildroot

## Table of Contents

- [Introduction](#introduction)
- [Dependencies](#dependencies)
- [Build](#build)

## Introduction

This project is to demonstrate the sony-nmos (Networked Media Open Specifications) using Buildroot. The project has only two scripts to run. The first will download buildroot, setup the dependencies and then build the Linux Core and associated root file system.

### The `work` Environment

The project does require one environment variable defined, '`work`'. This variable simply points to the root directory for this project. For example, if the project is located in `~/Source/sony-nmos-buildoot`, then export would look like:

```bash
export work=/home/someuser/Source/sony-nmos-buildroot
```

## Dependencies

- git
- c/c++ (build essentials)
- cmake

## Build

### Build Linux Kernel and File System

### Build for arm

- run $work/scripts/build-os.sh
- run $work/scripts/configure-build-arm.sh
- cd $work/reg-managerBuild/reg-manager_release
- make


