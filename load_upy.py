#!/usr/bin/python
# -*- coding: utf-8 -*-
"""uFlash Helper Script
The MicroPython hex file is saved into the following below, which you can drop
into the micro:bit USB drive for flashing:

    vagrant_shared/micropython/build/bbc-microbit-classic-gcc-nosd/source/microbit-micropython.hex

To simplify the process uflash has been included with this wrapper script to
load MicroPython with or without an additional Python program. So, from the
host operating system:
    python load_upy.py
or
    python load_upy.py <path to your python file>

For a quick test you could load a MicroPython examples for the micro:bit:
    python load_upy.py vagrant_shared/micropython/examples/conway.py
"""
from __future__ import (absolute_import, division,
                        print_function, unicode_literals)
import sys
import os
import time
from datetime import datetime, timedelta

sys.path.append(os.path.join('vagrant_shared', 'uflash'))
import uflash


if __name__ == '__main__':
    micropython_hex = os.path.join('vagrant_shared', 'micropython', 'build',
                                   'bbc-microbit-classic-gcc-nosd', 'source',
                                   'microbit-micropython.hex')
    if os.path.isfile(micropython_hex):
        #sys.argv.append('--runtime=%s' % micropython_hex)
        sys.argv[0] = '--runtime=%s' % micropython_hex
        file_timestamp = os.path.getmtime(micropython_hex)
        print('Flashing MicroPython modified on %s (%s ago):\n\t%s' %
              (datetime.fromtimestamp(file_timestamp).strftime("%Y-%m-%d %H:%M:%S"),
               timedelta(seconds=int(time.time() - file_timestamp)),
               micropython_hex))
        if len(sys.argv) > 1:
            print('With Python script: %s\n' % sys.argv[1])
        uflash.main(sys.argv)
        #print(sys.argv)
    else:
        print('The file %s does not exists' % micropython_hex +
              'are you sure you have built micropython successfully?')
