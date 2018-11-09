#!/bin/bash

awk="/usr/bin/awk"
echo="/bin/echo"
grep="/usr/bin/grep"
profiles="/usr/bin/profiles"
sw_vers="/usr/bin/sw_vers"

macos_version=$(${sw_vers} -productVersion | ${awk} -F '.' '{print $2}')

# Is the OS version macOS 10.13 or later? If so, don't install the MDM enrollment profile due to UAMDM.
if [[ "$macos_version" -ge 13 ]]; then
 ${echo} "macOS 10.13 or higher detected, aborting."
 exit 1
fi

# Is the profile already installed? If so, don't reinstall it.
if ${profiles} -L | ${grep} -q "your-profile-name"; then
 ${echo} "MDM enrollment profile already installed, aborting."
 exit 1
fi

# Is the OS version macOS 10.7 or later? If so, install the MDM enrollment profile.
if [[ "$macos_version" -ge 7 ]]; then
 ${echo} "macOS 10.7 to 10.12 detected, adding to queue."
 exit 0
fi

exit 0
