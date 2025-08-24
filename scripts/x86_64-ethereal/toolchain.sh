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
git submodule init
git submodule update
mkdir -pv build-output/sysroot/usr/include/
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
../gcc-${GCC_VERSION}/configure --prefix=/usr --target=x86_64-ethereal --disable-multilib --enable-languages=c,c++ --with-sysroot=/opt/Ethereal/build-output/sysroot/
make -j4 all-gcc
make install-gcc

cd /opt/Ethereal

# Download and extract ACPICA
wget https://downloadmirror.intel.com/834974/acpica-unix-20240927.tar.gz -O external/acpica/acpica.tar.gz
cd external/acpica
tar -xf acpica.tar.gz
mv acpica-unix-20240927 acpica-src
rm acpica.tar.gz

cd /opt/Ethereal
bash -c buildscripts/install-headers.sh

cd /opt/toolchain/build-gcc/

make -j4 all-target-libgcc
make install-target-libgcc

echo === GCC BUILD FINISHED ===

#make -j4 all-target-libstdc++-v3 
#make install-target-libstdc++-v3

cd /opt/
rm -rf toolchain
