#!/bin/sh

VERSION=14.2

mkdir /opt/toolchain/
cd /opt/toolchain

wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-$VERSION.rel1-x86_64-aarch64-none-elf.tar.xz /opt/toolchain/aarch64.tar.xz
tar -xf aarch64.tar.xz
cd arm-gnu-toolchain-$VERSION.rel1-x86_64-aarch64-none-elf

cp -r aarch64-none-elf /usr/
cp -r bin /usr/
cp -r include /usr/
cp -r lib /usr/
cp -r libexec /usr/
cp -r share /usr/

