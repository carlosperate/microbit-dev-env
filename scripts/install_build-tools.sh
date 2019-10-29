#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "Build Tools: Installing git..."
sudo apt-get update -qq
sudo apt-get install -y git
pretty_echo "Build Tools: Installing extra Python dependencies..."
sudo apt-get install -y python-setuptools python-dev python-pip python3-dev python3-pip
pretty_echo "Build Tools: Installing general C/C++ build tools..."
sudo apt-get install -y cmake ninja-build srecord build-essential
