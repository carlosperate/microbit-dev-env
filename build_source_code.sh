#!/bin/sh
echo "# Configuring yotta...\n"
echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* PLESE NOTE: You need to sign in to your mbed account, open the link printed below ! *"
echo "*                                                                                     *"
echo "***************************************************************************************\n"
yt login
echo "#\n# Build C++ examples using DAL\n#"
cd vagrant_shared/cpp-samples
yt clean
yt target bbc-microbit-classic-gcc
yt build
echo "#\n# Build C++ template for DAL v1\n#"
cd ../cpp-template-dal-v1
yt clean
yt target bbc-microbit-classic-gcc
yt build
echo "#\n# Build MicroPython\n#"
cd ../micropython
yt clean
yt target bbc-microbit-classic-gcc-nosd
yt up
yt build
echo "#\n# C++ DAL v1 hello world hex file location:"
echo "#   vagrant_shared/cpp-template-dal-v1/build/bbc-microbit-classic-gcc/src/microbit-dalv1-template-combined.hex"
echo "#\n# C++ hello world hex file location:"
echo "#   vagrant_shared/cpp-samples/build/bbc-microbit-classic-gcc/source/microbit-samples-combined.hex"
echo "#\n# MicroPython hex file location:"
echo "#   vagrant_shared/micropython/build/bbc-microbit-classic-gcc-nosd/source/microbit-micropython.hex\n#"
