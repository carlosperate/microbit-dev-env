#!/bin/sh
set -x #echo on

# Download sources
cd vagrant_shared
echo "#\n# Cloning MicroPython repository...\n#"
git clone https://github.com/bbcmicrobit/micropython.git
echo "#\n# Cloning uFlash repository...\n#"
git clone https://github.com/ntoll/uflash.git
echo "#\n# Cloning microREPL...\n#"
sudo -H pip install pyserial
sudo -H pip3 install pyserial
git clone https://github.com/ntoll/microrepl.git

# Build it
echo "#\n# Build MicroPython\n#"
cd micropython
yt clean
yt target bbc-microbit-classic-gcc-nosd
yt up
yt build
echo "#\n# MicroPython hex file location:"
echo "#   vagrant_shared/micropython/build/bbc-microbit-classic-gcc-nosd/source/microbit-micropython.hex\n#"
