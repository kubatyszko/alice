#!/usr/bin/env python

# Get the current size of the terminal window, and set stty size accordingly.
# A replacement for xterm's resize program, with no X dependency.
# Useful when logged in over a serial line.
# Copyright 2013,2017 by Akkana Peck. Share and enjoy under the GPL v2 or later.

# In the unlikely event you ever need to *set* the terminal size, check out:
# https://github.com/zerorax/pyresize/blob/master/resize.py

import os, sys
import fcntl
import struct
import time
import re
import tty
import termios
import select

# python3 has get_terminal size, but it doesn't actually query
# the terminal, just trusts current stty settings, which isn't
# useful here. But 3 has different open() characteristics so we
# have to detect version, not just features.
if (sys.version_info < (3, 0)):
    ttyfd = open('/dev/tty', 'r+')
else:
    # Python3 needs extra flags set, which requires a 2-step open process:
    fd = os.open('/dev/tty', os.O_RDWR|os.O_NOCTTY)
    ttyfd = open(fd, 'wb+', buffering=0)

# Save the terminal state
fileno = sys.stdin.fileno()
stty_sav = termios.tcgetattr(sys.stdin)
fc_sav = fcntl.fcntl(fileno, fcntl.F_GETFL)

# Turn off echo.
stty_new = termios.tcgetattr(sys.stdin)
stty_new[3] = stty_new[3] & ~termios.ECHO
termios.tcsetattr(sys.stdin, termios.TCSADRAIN, stty_new)

ttyfd.write(b'\033[7\033[r\033[999;999H\033[6n')
ttyfd.flush()

# Put stdin into cbreak mode.
# Python2 can use fd here, but in Python3 we have to get sys.stdin.fileno.
tty.setcbreak(sys.stdin)

# Nonblocking mode.
fcntl.fcntl(fileno, fcntl.F_SETFL, fc_sav | os.O_NONBLOCK)

try:
    while True:
        r, w, e = select.select([ttyfd], [], [])
        if r:
            output = sys.stdin.read()
            break
finally:
    # Reset the terminal back to normal cooked mode
    termios.tcsetattr(fileno, termios.TCSAFLUSH, stty_sav)
    fcntl.fcntl(fileno, fcntl.F_SETFL, fc_sav)

rows, cols = list(map(int, re.findall(r'\d+', output)))

fcntl.ioctl(ttyfd, termios.TIOCSWINSZ,
            struct.pack("HHHH", rows, cols, 0, 0))

print("\nReset the terminal to %d rows, %d cols" % (rows, cols))





