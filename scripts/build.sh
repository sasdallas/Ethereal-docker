#!/bin/sh

# Clone Ethereal
rm -rf /opt/Ethereal
git clone https://github.com/sasdallas/Ethereal /opt/Ethereal
cd /opt/Ethereal
git config --global --add safe.directory /opt/Ethereal
git submodule init
git submodule update

# Setup architecture
cp /opt/build/arch.sh /opt/Ethereal/buildscripts/build-arch.sh

# Download and extract ACPICA
wget https://downloadmirror.intel.com/834974/acpica-unix-20240927.tar.gz -O external/acpica/acpica.tar.gz
cd external/acpica
tar -xf acpica.tar.gz
mv acpica-unix-20240927 acpica-src
rm acpica.tar.gz

cd /opt/Ethereal

make all
