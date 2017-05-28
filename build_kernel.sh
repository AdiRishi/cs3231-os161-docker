#!/bin/bash

# fail if any command returns a non-zero code
set -e

base=${1:-'/home'}
src_base="${base}/${2:-os161-src}"

cd "${src_base}"
./configure --ostree="${base}/root"
# Build and install user level programs
cd "${src_base}"
bmake
bmake install
# configure ASST3
cd "${src_base}/kern/conf"
./config ASST3
# make and install the kernel
cd "${src_base}/kern/compile/ASST3"
bmake depend
bmake
bmake install
# move to the base directory
cd "${base}"
