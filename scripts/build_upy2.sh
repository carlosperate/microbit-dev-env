#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ tput setaf 3; echo -e "\n#\n#\n# $1\n#\n#"; tput sgr0; set -x; }; f'
alias error_echo='{ set +x; } 2> /dev/null; f(){ tput setaf 1; echo -e "\n#\n#\n# $1\n#\n#" >&2; tput sgr0; set -x; }; f'

# Download sources
cd ~/vagrant_shared
pretty_echo "Upy V2: Cloning MicroPython repository..."
git clone https://github.com/microbit-foundation/micropython-microbit-v2.git
mkdir python_helpers

# Build it
pretty_echo "Upy V2: Building MicroPython..."
cd ~/vagrant_shared/micropython-microbit-v2
git submodule update --init
make -C lib/micropython/mpy-cross
cd src
make
if [ "$?" -eq "0" ]; then
  pretty_echo "Upy V2: MicroPython hex file location:\n#    vagrant_shared/micropython-microbit-v2/src/MICROBIT.hex"
else
  error_echo "Upy V2: BUILD FAILED!"
fi

