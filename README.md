# sony-nmos-buildroot

## Table of Contents

- [Introduction](#introduction)
- [Dependencies](#dependencies)
- [Build](#build)

## Introduction

This project is to demonstrate the sony-nmos (Networked Media Open Specifications) using Buildroot. 

## Dependencies

- c/c++
- cmake
- Avahi (libavahi-compat, libavahi-compat-libdnssd-dev)
- OpenSSL (libssl-dev)
- https (TLS)
- websocketpp
- ptp (Linux PTP Project)
- [C++ REST SDK](https://github.com/Microsoft/cpprestsdk) Note: This library clones it's own websocketpp
  - libboost-dev
    - boost-random-dev
    - boost-system-dev
    - boost-filesystem-dev
    - boost-chrono-dev
    - boost-atomic-dev
    - boost-date_time-dev
    - boost-regex-dev
    - boost-thread-dev

## Build

Currently this is constantly changing. 

### Build for arm

- run $work/scripts/build-os.sh
- run $work/scripts/configure-build-arm.sh
- cd $work/reg-managerBuild/reg-manager_release
- make

## Embedded Notes

### Buildroot Notes

- Added libcpprestsdk (this will add a some boost libraries)
- Added websocketpp
- Added local in tool-chain (BR2_TOOLCHAIN_BUILDROOT_LOCALE=y)
- Added Avahi
