#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

# Needs GCC-ARM and Yotta to be installed as well, Vagrant file should have installed this already
pretty_echo "PXT: Removing present installation of node and npm..."
sudo apt-get update -qq
sudo apt-get remove -y nodejs npm
pretty_echo "PXT: Installing node.js and npm..."
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

pretty_echo "PXT: Global install of the PXT cli tool..."
sudo npm install -g pxt
# There was an issue with old versions of npm where the cache folder contains root-owned files
sudo chown -R 1000:1000 "/home/vagrant/.npm"

# pretty_echo "PXT: Set up MakeCode stable v5..."
# git clone https://github.com/microsoft/pxt.git --branch v5.15.17 --single-branch --depth 1
# cd ~/vagrant_shared/pxtworkspace/pxt
# npm install
# npm run build
# sudo npm install -g pxt

pretty_echo "PXT: Set up MakeCode micro:bit target..."
cd ~/vagrant_shared
mkdir -p pxtworkspace
cd ~/vagrant_shared/pxtworkspace
pxt target microbit
{ set +x; } 2> /dev/null
echo "#\n#\n# PXT workspace set up at vagrant_shared/pxtworkspace, to run server:"
echo "#   pxt serve --no-browser --no-serial --hostname 0.0.0.0 --port 3232 --wsport 3233"
echo "# Then connect from host machine at http://localhost:3232 with the local"
echo "# token shown on the terminal.\n#\n#"
