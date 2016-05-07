#!/bin/sh
cd vagrant_shared
echo "#\n# Cloning C++ Examples\n#"
git clone https://github.com/lancaster-university/microbit-samples.git cpp-samples
echo "#\n# Cloning MicroPython repository...\n#"
git clone https://github.com/bbcmicrobit/micropython.git
echo "#\n# Cloning uFlash repository...\n#"
git clone https://github.com/ntoll/uflash.git
echo "#\n# Cloning microREPL...\n#"
sudo -H pip install pyserial
sudo -H pip3 install pyserial
git clone https://github.com/ntoll/microrepl.git
