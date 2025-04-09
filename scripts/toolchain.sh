#!/bin/sh

# toolchain.sh - Install toolchain

export HOST=${HOST:-$(/opt/build/arch.sh)}

/opt/build/${HOST}/toolchain.sh