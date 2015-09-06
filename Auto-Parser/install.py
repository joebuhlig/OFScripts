#!/usr/bin/env python

from __future__ import division, absolute_import
from __future__ import print_function, unicode_literals

import os
import plistlib as plist
import pwd
import subprocess
import sys

LAUNCH_AGENT = 'of.autoparser.plist'
DEFAULT_INTERVAL = 300

p = plist.readPlist(LAUNCH_AGENT)

try:
    # Get user input
    interval = raw_input('Interval in seconds [300]: ')
    # If user supplied a value
    if interval:
        # Try converting the user's input to a number
        interval = int(interval)
except ValueError:
    print("Provided value is not a number!", file=sys.stderr)
    # Exit program if the user input cannot be parsed into a number
    exit(1)

# Use user supplied value if given otherwise use the default interval
p['StartInterval'] = interval if interval else DEFAULT_INTERVAL

# Get current working directory
cwd = os.getcwd()

# Modify ProgramArguments to use current PWD
p['ProgramArguments'][1] = '{}/ParseInbox.applescript'.format(cwd)

# Write modified plist file
plist.writePlist(p, LAUNCH_AGENT)

# Get current username
username = pwd.getpwuid(os.getuid())[0]

# Symlink plist file to ~/Library/LaunchAgents
os.symlink('{}/{}'.format(cwd, LAUNCH_AGENT),
           '/Users/{}/Library/LaunchAgents/{}'.format(username, LAUNCH_AGENT))

# Load launch agent with launchtl
subprocess.call(['launchctl', 'load',
                 '/Users/{}/Library/LaunchAgents/{}'.format(username,
                                                            LAUNCH_AGENT)])

# Start launch agent with launchctl
subprocess.call(['launchctl', 'start',
                 '/Users/{}/Library/LaunchAgents/{}'.format(username,
                                                            LAUNCH_AGENT)])
