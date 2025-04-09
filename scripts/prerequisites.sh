#!/bin/sh

# prerequisites.sh - Installs prerequisites

apt-get update
apt-get install -y build-essential sudo wget lsb-release
apt-get install -y grub-common xorriso git libmpfr-dev libmpc-dev libgmp-dev qemu-system autoconf automake texinfo pkg-config flex bison
