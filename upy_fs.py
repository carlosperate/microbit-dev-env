#!/usr/bin/python
# -*- coding: utf-8 -*-
"""microFS helper script
The pySerial module is the only dependency for microFS, and so it has been
included in the python_helpers directory. This script adds the required modules
to the Python path so that the microFS command line utility can be accessed
from the host computer without requiring anything other than Python (2 or 3).
"""
from __future__ import (absolute_import, division,
                        print_function, unicode_literals)
import sys
import os
import time
from datetime import datetime, timedelta

python_helpers_dir = os.path.join('vagrant_shared', 'python_helpers')
sys.path.append(os.path.join(python_helpers_dir, 'pyserial'))
sys.path.append(os.path.join(python_helpers_dir, 'microfs'))
import microfs


if __name__ == '__main__':
    microfs.main(sys.argv[1:])
