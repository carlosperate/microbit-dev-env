#!/bin/sh
echo "#\n# Removing possible installation of GCC ARM compiler...\n#"
sudo apt-get remove binutils-arm-none-eabi gcc-arm-none-eabi
echo "#\n# Installing GCC ARM compiler...\n#"
sudo add-apt-repository -y ppa:team-gcc-arm-embedded/ppa
sudo apt-get update -qq
sudo apt-get install -y gcc-arm-embedded
echo "#\n# Checking GCC ARM compiler version...\n#"
arm-none-eabi-gcc --version
