#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "Installing yotta dependencies..."
sudo apt-get update -qq
sudo apt-get install -y python-setuptools python-dev cmake build-essential ninja-build libffi-dev libssl-dev libreadline-dev libyaml-dev
pretty_echo "Installing pip..."
sudo easy_install pip
sudo pip install -U pip
# Temporary workaround for https://github.com/carlosperate/microbit-dev-env/issues/5
pretty_echo "Downgrading pip to v9 due to package issues with v10..."
sudo -H pip install pip==9.0.3
pretty_echo "Installing yotta..."
sudo -H pip install yotta
