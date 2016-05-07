#!/bin/bash
echo "# Configuring yotta...\n"
echo "**************************************************************************************"
echo "*                                                                                    *"
echo "* PLESE NOTE: You need to signin to your mbed account, open the link printed below ! *"
echo "*                                                                                    *"
echo "**************************************************************************************\n"
yt login
echo "#\n# Build C++ examples\n#"
cd vagrant_shared/cpp-samples
yt target bbc-microbit-classic-gcc
yt build
echo "#\n# Build MicroPython\n#"
cd ../micropython
yt target bbc-microbit-classic-gcc-nosd
yt up
yt build
