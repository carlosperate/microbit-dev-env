#!/bin/sh
echo "#\n# Apt update...\n#"
sudo apt-get update
echo "#\n# Installing git...\n#"
sudo apt-get install -y git
echo "#\n# Installing extra python and pip...\n#"
sudo apt-get install -y python-setuptools python-dev python-pip python3-pip
sudo pip install -U pip
echo "#\n# Installing general build tools...\n#"
sudo apt-get install -y build-essential libreadline-dev libffi-dev libssl-dev libyaml-dev
echo "#\n# Installing the compiler...\n#"
sudo apt-get remove binutils-arm-none-eabi gcc-arm-none-eabi
sudo add-apt-repository ppa:terry.guo/gcc-arm-embedded
sudo add-apt-repository -y ppa:pmiller-opensource/ppa
sudo apt-get update
sudo apt-get install -y cmake ninja-build gcc-arm-none-eabi=4.9.3.2015q3-1trusty1 srecord
arm-none-eabi-gcc --version
echo "#\n# Installing yotta...\n#"
sudo -H pip install yotta
