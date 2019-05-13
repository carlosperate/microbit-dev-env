#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "Yotta: Installing yotta dependencies..."
sudo apt-get update -qq
sudo apt-get install -y python-setuptools python-dev cmake build-essential ninja-build libffi-dev libssl-dev libreadline-dev libyaml-dev
pretty_echo "Yotta: Installing pip..."
sudo easy_install pip
sudo pip install -U pip
pretty_echo "Yotta: Installing yotta..."
sudo -H pip install yotta
