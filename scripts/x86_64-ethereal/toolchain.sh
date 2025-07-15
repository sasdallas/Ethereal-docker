#!/bin/sh

# Install x86_64-elf toolchain

set -e

GCC_VERSION=12.2.0
BINUTILS_VERSION=2.39

# /opt/toolchain
mkdir /opt/toolchain

# We need to clone Ethereal and install libpolyhedron headers
git clone https://github.com/sasdallas/Ethereal /opt/Ethereal
cd /opt/Ethereal/
mkdir -pv build-output/sysroot/usr/include/
cp -rp /opt/Ethereal/libpolyhedron/include/ build-output/sysroot/usr/
cp -rp /opt/Ethereal/libpolyhedron/arch/x86_64/include/ build-output/sysroot/usr/
cd /opt/toolchain

# Download Ethereal toolchain
git clone https://github.com/sasdallas/Ethereal-Toolchain /opt/toolchain/Ethereal-Toolchain

# Get and extract binutils
wget https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz
tar -xf binutils-${BINUTILS_VERSION}.tar.xz

# Apply patch to binutils
cd binutils-${BINUTILS_VERSION}
patch -p1 < /opt/toolchain/Ethereal-Toolchain/binutils-${BINUTILS_VERSION}.patch
cd ..

# Build binutils
mkdir build-binutils
cd build-binutils
../binutils-${BINUTILS_VERSION}/configure --prefix=/usr --target=x86_64-ethereal --with-sysroot=/opt/Ethereal/build-output/sysroot --disable-werror
make -j4
make install

# Get and extract GCC
cd /opt/toolchain
wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz
tar -xf gcc-${GCC_VERSION}.tar.xz

# Patch GCC
cd gcc-${GCC_VERSION}
patch -p1 < /opt/toolchain/Ethereal-Toolchain/gcc-${GCC_VERSION}.patch
cd ..

mkdir build-gcc
cd build-gcc

# C++ building is a bit messed up
../gcc-${GCC_VERSION}/configure --prefix=/usr --target=x86_64-ethereal --disable-multilib --enable-languages=c --with-sysroot=/opt/Ethereal/build-output/sysroot/
make -j4 all-gcc
make -j4 all-target-libgcc
make install-gcc install-target-libgcc

cd /opt/
rm -rf toolchain
