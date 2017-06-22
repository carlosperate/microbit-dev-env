#!/bin/sh
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

# The following is juts a temporary patch to resolve:
#   https://github.com/bbcmicrobit/micropython/issues/363
echo "#\n# Applying patch to MicroPython...\n#"
cd micropython
git apply -v ../upy_increase_heap.patch --ignore-space-change --ignore-whitespace

# Build it
echo "# Configuring yotta...\n"
echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* PLESE NOTE: You need to sign in to your mbed account, open the link printed below ! *"
echo "*                                                                                     *"
echo "***************************************************************************************\n"
yt login
echo "#\n# Build MicroPython\n#"
cd ../micropython
yt clean
yt target bbc-microbit-classic-gcc-nosd
yt up
yt build
echo "#\n# MicroPython hex file location:"
echo "#   vagrant_shared/micropython/build/bbc-microbit-classic-gcc-nosd/source/microbit-micropython.hex\n#"
