#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import (absolute_import, division,
                        print_function, unicode_literals)
import sys
import os

sys.path.append(os.path.join('vagrant_shared', 'uflash'))
import uflash

if __name__ == '__main__':
    micropython_hex = os.path.join('vagrant_shared', 'micropython', 'build',
                                   'bbc-microbit-classic-gcc-nosd', 'source',
                                   'microbit-micropython.hex')
    if os.path.isfile(micropython_hex):
        #sys.argv.append('--runtime=%s' % micropython_hex)
        sys.argv[0] = '--runtime=%s' % micropython_hex
        if len(sys.argv) > 1:
            print('Flashing script: %s' % sys.argv[1])
        else:
            print('Flashing only micropython.')
        uflash.main(sys.argv)
        #print(sys.argv)
    else:
        print('The file %s does not exists' % micropython_hex +
              'are you sure you have built micropython successfully?')

