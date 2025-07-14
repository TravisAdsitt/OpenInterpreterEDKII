#!/bin/bash
set -e

# === Load environment variables from .env ===
if [ -f /root/.env ]; then
  export $(grep -v '^#' /root/.env | xargs)
fi

# Set up EDK II environment
cd /root/edk2
export EDK2_PATH=/root/edk2
source ./edksetup.sh
make -C BaseTools

# Set necessary env vars
export PACKAGES_PATH=$EDK2_PATH:/root/edk2-platforms:/root/edk2-non-osi:/root/edk2-libc
export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-

# Launch OpenInterpreter in server mode
echo "Starting OpenInterpreter server..."
interpreter --server -y -pl --loop
