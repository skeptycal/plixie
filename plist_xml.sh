#!/usr/bin/env zsh
###############################################################################
# plist_xml.sh
#
# Sample shell script to convert a .plist file from binary to xml
#
# Parameters:
#
#   $1: name of file to convert (no default - must exist and be writable)
#   $2: format to convert to; in {xml1, binary, json} (default xml1)
#
# @author    Michael Treanor  <skeptycal@gmail.com>
# @copyright 2019 © Michael Treanor
# @license   MIT <https://opensource.org/licenses/MIT>
# @version   0.1.0
# @link      http://www.github.com/skeptycal
###############################################################################
# Prechecks
###############################################################################

MAIN='\u001b[38;5;229m'
WARN='\u001b[38;5;203m'
BLUE='\u001b[38;5;38m'
printf $MAIN

# test file config.plist - response should be
#   config.plist: Apple binary property list
# At least one parameter is required - it must be a valid filename
[ $# -eq 0 ] && { printf $WARN"\n-> $0 Parameters required.\n\n"$MAIN"Usage: $0 SOURCE [FORMAT]\n\t- SOURCE MUST BE A VALID .PLIST FILE.\n\t- FORMAT IN {XML1, BINARY, JSON} (DEFAULT XML1)"; exit 1; }

[ -!f ] && { printf $WARN"\n-> $0 Parameters required.\n\n"$MAIN"Usage: $0 SOURCE [FORMAT]\n\t- SOURCE MUST BE A VALID .PLIST FILE.\n\t- FORMAT IN {XML1, BINARY, JSON} (DEFAULT XML1)"; exit 1; }



###############################################################################
# Activate Sudo Environment
###############################################################################

# Sudo Environment: (optional, uncomment BOTH 'sudo -v' and 'while true ...')
# Get the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Function echoit($text)
# echo text with bold formatting

white='\u001b[37m'
purple='\u001b[38;5;93m'

###############################################################################
# Script Content
###############################################################################

printf $purple"Plist_xml"$white
printf '\n'
printf 'Convert macOS .plist files from binary to xml format.'

if [ -n $2 ]


echo "$0: File '${file}' not found."

if [ -a $1 ]
  then
    if [ - ]

    # Backup Preferences folder to Preferences.bak
    sudo cp -f $1 "$1.bak"
    # Change ownership on the plist file
    # sudo chown -v $(whoami):staff $temp_plist
    # Convert binary --> xml
    sudo plutil -convert xml1 $1
    if [ -nz $? ]
      echo "There was an error performing the conversion. (error code $?)"
    else
      echo "The file $1 was converted from binary to XML."
else
  echo "The file $1 does not exist in the current or given path."
fi



```

  - *do your editing or processing ...*
  - *test everything out ...*

```BASH
# convert back to default (xml --> binary)
# this may not be necessary, but ... why not
sudo plutil -convert binary1 com.apple.dock.plist

# restore default ownership
# also may be optional, but better safe ...
sudo chown -v root:wheel com.apple.dock.plist
```


""" Usage: file [OPTION...] [FILE...]
    Determine type of FILEs.
    """








# for file in ~/.dotfiles/.{path,bash_prompt_zsh,exports,aliases,functions,extra}; do
# 	[ -r "$file" ] && [ -f "$file" ] && source "$file";
# done;
# unset file;


###############################################################################
# General Cleanup
###############################################################################

killall Dock
