#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "Yotta: Installing yotta dependencies..."
sudo apt-get update -qq
sudo apt-get install -y python-setuptools python-dev python-pip cmake build-essential ninja-build libffi-dev libssl-dev libreadline-dev libyaml-dev
pretty_echo "Yotta: Updating pip..."
sudo -H pip install -U pip
pretty_echo "Yotta: Installing yotta..."
# FIXME There is an issue with Yotta so we need to install from a commit
# https://github.com/ARMmbed/yotta/pull/857
sudo -H pip install yotta==0.20.5
