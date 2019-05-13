#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "GCC: Removing present installation of GCC ARM compiler..."
sudo apt-get remove binutils-arm-none-eabi gcc-arm-none-eabi
pretty_echo "GCC: Installing GCC ARM compiler..."
sudo add-apt-repository -y ppa:team-gcc-arm-embedded/ppa
sudo apt-get update -qq
sudo apt-get install -y gcc-arm-embedded
pretty_echo "GCC: Checking GCC ARM compiler version..."
which arm-none-eabi-gcc
arm-none-eabi-gcc --version
