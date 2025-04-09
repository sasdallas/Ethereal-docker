#!/bin/sh

# Clone reduceOS
git clone https://github.com/sasdallas/reduceOS /opt/reduceOS
cd /opt/reduceOS

# Setup architecture
cp /opt/build/arch.sh /opt/reduceOS/buildscripts/build-arch.sh

# Download and extract ACPICA
wget https://downloadmirror.intel.com/834974/acpica-unix-20240927.tar.gz -O external/acpica/acpica.tar.gz
cd external/acpica
tar -xf acpica.tar.gz
mv acpica-unix-20240927 acpica-src
rm acpica.tar.gz

cd /opt/reduceOS

make all