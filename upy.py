#!/usr/bin/python
# -*- coding: utf-8 -*-
"""MicroPython helper script

This script provides the functionality to flash MicroPython to the micro:bit,
open the MicroPython REPL, or transfer files to the MicroPython file system.
It does so by providing an easy to use wrapper around the uFlash, microREPL,
and microFS Python modules.

These modules and their dependencies have been downloaded as part of the
Vagrant provisioning step and are included to the system path from the
`vagrant_shared/python_helpers` directory.

This means that the host computer only needs to have Python installed, without
any other Python dependencies or modules.

uFlash
======
The MicroPython hex file is saved into the directory below, which you can drop
into the micro:bit USB drive for flashing:

    vagrant_shared/micropython/build/firmware.hex

To simplify the process uflash has been included with this wrapper script to
load MicroPython with or without an additional Python program. So, from the
host operating system:
    python upy.py flash
or
    python upy.py flash <path to your python file>

For a quick test you could load a MicroPython examples for the micro:bit:
    python upy.py flash vagrant_shared/micropython/examples/conway.py


microREPL
=========
Launched with: python upy.py repl
The pySerial module is the only dependency and included in python_helpers.
This command enters the micro:bit MicroPython REPL directly via serial.


microFS
=======
Launched with: python upy.py fs <args>
The pySerial module is the only dependency and included in python_helpers.
All the arguments are passed through to microFS.
"""
from __future__ import (absolute_import, division,
                        print_function, unicode_literals)
import sys
import os
import time
from datetime import datetime, timedelta


# Figure out full paths to the required folders
project_root = os.path.dirname(os.path.realpath(__file__))
py_helpers_dir = os.path.join(project_root, 'vagrant_shared', 'python_helpers')

# Add Python modules closed in the Vagrant shared folder to the system path
sys.path.append(os.path.join(py_helpers_dir, 'pyserial'))
sys.path.append(os.path.join(py_helpers_dir, 'uflash'))
sys.path.append(os.path.join(py_helpers_dir, 'microfs'))
sys.path.append(os.path.join(py_helpers_dir, 'microrepl'))


def flash():
    import uflash
    micropython_hex = os.path.join(project_root, 'vagrant_shared',
                                   'micropython', 'build', 'firmware.hex')
    if os.path.isfile(micropython_hex):
        uflash_args = sys.argv[2:]
        uflash_args.append('--runtime=%s' % micropython_hex)
        # Print useful information about the MicroPython hex time stamp
        file_timestamp = os.path.getmtime(micropython_hex)
        print('Flashing MicroPython modified on %s (%s ago):\n\t%s' %
              (datetime.fromtimestamp(file_timestamp).strftime("%Y-%m-%d %H:%M:%S"),
               timedelta(seconds=int(time.time() - file_timestamp)),
               micropython_hex))
        # If flashing with a Python script print the info
        if len(sys.argv) > 2:
            print('With Python script: %s\n' % sys.argv[2])
        # print(uflash_args)
        uflash.main(uflash_args)
    else:
        print('The file %s does not exists' % micropython_hex +
              'are you sure the MicroPython build was successful?')
        sys.exit(1)


def fs():
    import microfs
    microfs.main(sys.argv[2:])


def repl():
    import microrepl
    microrepl.main()


def main():
    if sys.argv[1].lower() == 'flash':
        flash()
    elif sys.argv[1].lower() == 'fs':
        fs()
    elif sys.argv[1].lower() == 'repl':
        repl()
    else:
        print('Unrecognised command, please use of the of following three:\n\n'
              'flash - To flash MicroPython with or without a Python script\n'
              '        For example: python upy.py flash vagrant_shared/micropython/examples/conway.py\n'
              'fs    - To transfer files to a micro:bit running MicroPython\n'
              '        To get more info use: python upy.py fs -h\n'
              'repl  - To enter the micro:bit MicroPython REPL\n')
        sys.exit(1)


if __name__ == '__main__':
    main()
