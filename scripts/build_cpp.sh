#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

# Download sources
cd ~/vagrant_shared
pretty_echo "DAL: Cloning C++ Examples..."
git clone https://github.com/lancaster-university/microbit-samples.git cpp-samples

# Build it
pretty_echo "DAL: Building C++ examples using DAL..."
cd cpp-samples
yt clean
yt target bbc-microbit-classic-gcc
yt build
{ set +x; } 2> /dev/null
echo "#\n# C++ hello world hex file location:"
echo "#   vagrant_shared/cpp-samples/build/bbc-microbit-classic-gcc/source/microbit-samples-combined.hex\n#\n#"
