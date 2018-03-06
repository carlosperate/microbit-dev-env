#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "Installing git..."
sudo apt-get update -qq
sudo apt-get install -y git
pretty_echo "Removing possible installation of node and npm..."
sudo apt-get remove -y nodejs npm
pretty_echo "Installing node.js build tools..."
sudo apt-get install -y build-essential
pretty_echo "Installing node.js and npm..."
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
pretty_echo "Installing yotta dependencies..."
sudo apt-get install -y python-setuptools cmake build-essential ninja-build python-dev libffi-dev libssl-dev
pretty_echo "Installing pip..."
sudo easy_install pip
sudo pip install -U pip
pretty_echo "Installing yotta..."
sudo -H pip install yotta
pretty_echo "Installing PXT..."
sudo npm install -g pxt
pretty_echo "Installing PXT build dependencies..."
sudo npm install -g jake
sudo npm install -g typings
