#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

# Needs GCC-ARM and Yotta to be installed as well, Vagrant file should have installed this already
pretty_echo "PXT: Installing git..."
sudo apt-get update -qq
sudo apt-get install -y git
pretty_echo "PXT: Removing present installation of node and npm..."
sudo apt-get remove -y nodejs npm
pretty_echo "PXT: Installing node.js build tools..."
sudo apt-get install -y build-essential
pretty_echo "PXT: Installing node.js and npm..."
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
pretty_echo "PXT: Installing PXT..."
sudo npm install -g pxt
pretty_echo "PXT: Installing PXT build dependencies..."
sudo npm install -g jake
sudo npm install -g typings
