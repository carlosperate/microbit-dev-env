#!/bin/sh
echo "#\n#\n# Set up micro:bit target...\n#\n#"
set -x;
cd vagrant_shared
mkdir -p pxtworkspace
cd pxtworkspace
npm install pxt-microbit --no-bin-links
pxt target microbit
{ set +x; } 2> /dev/null
echo "#\n#\n# PXT workspace set up at vagrant_shared/pxtworkspace, to run server:"
echo "#   pxt serve --no-browser --no-serial --hostname 0.0.0.0 --port 3232 --wsport 3233"
echo "# Then connect from host machine at http://localhost:3232 with the local"
echo "# token shown on the terminal.\n#\n#"
