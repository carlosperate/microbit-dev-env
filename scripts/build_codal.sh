#!/bin/bash -i
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ tput setaf 3; echo -e "\n#\n#\n# $1\n#\n#"; tput sgr0; set -x; }; f'
alias error_echo='{ set +x; } 2> /dev/null; f(){ tput setaf 1; echo -e "\n#\n#\n# $1\n#\n#" >&2; tput sgr0; set -x; }; f'

# Download sources
cd ~/vagrant_shared
pretty_echo "CODAL: Cloning CODAL head repository..."
git clone https://github.com/lancaster-university/microbit-v2-samples.git

# Build it
pretty_echo "CODAL: Building CODAL..."
cd ~/vagrant_shared/microbit-v2-samples
python3 build.py
if [ "$?" -eq "0" ]; then
  pretty_echo "CODAL: Built hex location:\n#    vagrant_shared/microbit-v2-samples/MICROBIT.hex"
else
  error_echo "CODAL: BUILD FAILED!"
fi
