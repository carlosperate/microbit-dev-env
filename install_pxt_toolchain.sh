#!/bin/sh
echo "#\n# Apt update...\n#"
sudo apt-get update -qq
echo "#\n# Installing git...\n#"
sudo apt-get install -y git
echo "#\n# Installing node.js and npm...\n#"
sudo apt-get remove -y nodejs npm
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "#\n# Installing node.js build tools...\n#"
sudo apt-get install -y build-essential
echo "#\n# Installing yotta dependencies...\n#"
sudo apt-get install -y python-setuptools cmake build-essential ninja-build python-dev libffi-dev libssl-dev
sudo easy_install pip
sudo pip install -U pip
echo "#\n# Installing yotta...\n#"
sudo -H pip install yotta
echo "#\n# Installing PXT...\n#"
sudo npm install -g pxt
echo "#\n# Installing PXT build dependencies...\n#"
sudo npm install -g jake
sudo npm install -g typings
