#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "Installing git..."
sudo apt-get update -qq
sudo apt-get install -y git
pretty_echo "Installing extra Python dependencies..."
sudo apt-get install -y python-setuptools python-dev python-pip python3-pip
pretty_echo "Installing pip..."
sudo easy_install pip
sudo pip install -U pip
pretty_echo "Installing general build tools..."
sudo apt-get install -y cmake ninja-build srecord build-essential
pretty_echo "Installing yotta dependencies..."
sudo apt-get install -y libreadline-dev libffi-dev libssl-dev libyaml-dev
pretty_echo "Installing yotta..."
sudo -H pip install yotta
