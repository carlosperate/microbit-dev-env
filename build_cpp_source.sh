#!/bin/sh
set -x #echo on

# Download sources
cd vagrant_shared
echo "#\n# Cloning C++ Examples\n#"
git clone https://github.com/lancaster-university/microbit-samples.git cpp-samples
echo "#\n# Cloning C++ Template for older DAL\n#"
git clone https://github.com/carlosperate/microbit-dal-v1-cpp-template.git cpp-template-dal-v1

# Build it
echo "#\n# Build C++ examples using DAL\n#"
cd cpp-samples
yt clean
yt target bbc-microbit-classic-gcc
yt build
echo "#\n# Build C++ template for DAL v1\n#"
cd ../cpp-template-dal-v1
yt clean
yt target bbc-microbit-classic-gcc
yt build
echo "#\n# C++ DAL v1 hello world hex file location:"
echo "#   vagrant_shared/cpp-template-dal-v1/build/bbc-microbit-classic-gcc/src/microbit-dalv1-template-combined.hex"
echo "#\n# C++ hello world hex file location:"
echo "#   vagrant_shared/cpp-samples/build/bbc-microbit-classic-gcc/source/microbit-samples-combined.hex"
