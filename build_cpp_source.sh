#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

# Download sources
cd ~/vagrant_shared
pretty_echo "Cloning C++ Examples..."
git clone https://github.com/lancaster-university/microbit-samples.git cpp-samples
pretty_echo "Cloning C++ Template for older DAL..."
git clone https://github.com/carlosperate/microbit-dal-v1-cpp-template.git cpp-template-dal-v1

# Build it
pretty_echo "Building C++ examples using DAL..."
cd cpp-samples
yt clean
yt target bbc-microbit-classic-gcc
yt build
pretty_echo "Building C++ template for DAL v1..."
cd ../cpp-template-dal-v1
yt clean
yt target bbc-microbit-classic-gcc
yt build
{ set +x; } 2> /dev/null
echo "#\n#\n# C++ DAL v1 hello world hex file location:"
echo "#   vagrant_shared/cpp-template-dal-v1/build/bbc-microbit-classic-gcc/src/microbit-dalv1-template-combined.hex"
echo "#\n# C++ hello world hex file location:"
echo "#   vagrant_shared/cpp-samples/build/bbc-microbit-classic-gcc/source/microbit-samples-combined.hex\n#\n#"
