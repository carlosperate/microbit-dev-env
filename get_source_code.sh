#!/bin/sh
cd vagrant_shared
echo "#\n# Cloning C++ Examples\n#"
git clone https://github.com/lancaster-university/microbit-samples.git cpp-samples
echo "#\n# Cloning C++ Template for older DAL\n#"
git clone https://github.com/carlosperate/microbit-dal-v1-cpp-template.git cpp-template-dal-v1
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
