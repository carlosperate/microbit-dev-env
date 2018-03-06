#!/bin/sh
set -x #echo on

echo "#\n# Apt update...\n#"
sudo apt-get update -qq
echo "#\n# Installing git...\n#"
sudo apt-get install -y git
echo "#\n# Installing extra Python dependencies...\n#"
sudo apt-get install -y python-setuptools python-dev python-pip python3-pip
echo "#\n# Installing pip...\n#"
sudo easy_install pip
sudo pip install -U pip
echo "#\n# Installing general build tools...\n#"
sudo apt-get install -y cmake ninja-build srecord build-essential
echo "#\n# Installing yotta dependencies...\n#"
sudo apt-get install -y libreadline-dev libffi-dev libssl-dev libyaml-dev
echo "#\n# Installing yotta...\n#"
sudo -H pip install yotta
