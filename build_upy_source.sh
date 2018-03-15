#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

# Download sources
cd vagrant_shared
pretty_echo "Cloning MicroPython repository..."
git clone https://github.com/bbcmicrobit/micropython.git
pretty_echo "Cloning uFlash repository..."
git clone https://github.com/ntoll/uflash.git
pretty_echo "Cloning microREPL..."
sudo -H pip install pyserial
sudo -H pip3 install pyserial
git clone https://github.com/ntoll/microrepl.git

# Build it
pretty_echo "Building MicroPython..."
cd micropython
yt clean
yt target bbc-microbit-classic-gcc-nosd
yt up
yt build
{ set +x; } 2> /dev/null
echo "#\n#\n# MicroPython hex file location:"
echo "#   vagrant_shared/micropython/build/bbc-microbit-classic-gcc-nosd/source/microbit-micropython.hex\n#\n#"
