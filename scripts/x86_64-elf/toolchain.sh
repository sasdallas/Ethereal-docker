#!/bin/sh

# Install x86_64-elf toolchain

GCC_VERSION=11.4.0
BINUTILS_VERSION=2.38

# /opt/toolchain
mkdir /opt/toolchain
cd /opt/toolchain

# Get and extract binutils
wget https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz
tar -xf binutils-${BINUTILS_VERSION}.tar.xz
mkdir build-binutils
cd build-binutils
../binutils-${BINUTILS_VERSION}/configure --prefix=/usr --target=x86_64-elf --with-sysroot --disable-nls --disable-werror
make -j4
make install

# Get and extract GCC
cd /opt/toolchain
wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz
tar -xf gcc-${GCC_VERSION}.tar.xz
mkdir build-gcc
cd build-gcc

# C++ building is a bit messed up
../gcc-${GCC_VERSION}/configure --prefix=/usr --target=x86_64-elf --disable-nls --enable-languages=c --without-headers --disable-hosted-libstdcxx
make -j4 all-gcc
make -j4 all-target-libgcc
make install-gcc install-target-libgcc

cd /opt/
rm -rf toolchain
