#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "Yotta: Installing yotta dependencies..."
sudo apt-get update -qq
sudo apt-get install -y python3-setuptools python3-dev python3-pip python3-venv cmake build-essential ninja-build libffi-dev libssl-dev libreadline-dev libyaml-dev
pretty_echo "Yotta: Updating pip to a known version..."
sudo -H pip3 install -U pip==19.3.1
sudo -H pip3 install pipx
pipx ensurepath
pretty_echo "Yotta: Installing yotta..."
pipx install yotta==0.20.5
