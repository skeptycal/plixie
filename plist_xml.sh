#!/usr/bin/env zsh
###############################################################################
# plist_xml.sh
#
# Sample shell script to convert a .plist file from binary to xml
#
# Parameters:
#
#   $1: name of file to convert (no default - must exist and be writable)
#   $2: format to convert to; in {xml1, binary1, json} (default xml1)
#
# @author    Michael Treanor  <skeptycal@gmail.com>
# @copyright 2019 � Michael Treanor
# @license   MIT <https://opensource.org/licenses/MIT>
# @version   0.1.0
# @link      http://www.github.com/skeptycal
###############################################################################
# Prechecks
###############################################################################

MAIN='\u001b[38;5;229m'
WARN='\u001b[38;5;203m'
BLUE='\u001b[38;5;38m'
WHITE='\u001b[37m'
PURPLE='\u001b[38;5;93m'

usage="""${MAIN}NAME${WHITE}
    plist_xml - convert plist files

${MAIN}SYNOPSIS${WHITE}
    plist_xml SOURCE [FORMAT] [MINE]

${MAIN}DESCRIPTION${WHITE}
    Convert macOS plist file SOURCE to the optional FORMAT requested. The
    default format is xml1. If the file is already in the requested format,
    nothing is done. If the format requested is available, the file is
    translated and a copy is written with a new extension that reflects the
    new format.

    ${MAIN}SOURCE${WHITE} - existing plist file
    ${MAIN}FORMAT${WHITE} - optional format in (xml1 | binary1 | json)
        (default is xml1)
    ${MAIN}MINE${WHITE} - set to 'mine' to retain (non-sudo) ownership
        of the new file (default is current owner)

"""

###############################################################################
# Activate Sudo Environment
###############################################################################

current_user="$(whoami)"
# Sudo Environment: (optional, uncomment BOTH 'sudo -v' and 'while true ...')
# Get the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Script Content
###############################################################################

# escape hatch ...
function getout() {
    [[ -f "$new_file" ]] && rm -f "$new_file"
    printf "${WARN}${2} ${1}\n\n${WHITE}"
    printf "$usage"
    exit 1
}

########################
# test parameters
[[ -z "$1" ]] && getout "$1" "Required parameter missing. "
[[ -f "$1" ]] || getout "$1" "File not found: "
[[ -r "$1" ]] && file="$1" || getout "$1" "File not readable: "
# set format option to default or $2
[[ -z "$2" ]] && option='xml1' || option="$2"
[[ "$3" == 'mine' ]] && mine='mine' || mine=''
# test requested format
[[ -n $(echo 'xml1 binary1 json' | xargs -n1 echo | grep -e "^${option}$") ]] && echo "Requested file format: ${option}" || getout "$option" "Requested option not available: "

########################
# check file format
plutil -lint "$file"
[[ "$?" ]] && printf "File linting successful. Original format is valid: ${file}\n" || getout "$file" "File format incompatible: "

########################
# All tests checkout ... perform conversion
new_file="${file}.${option}"
# backup original
sudo cp -af "$file" "${file}.bak"
# create working copy
sudo cp -af "$file" "$new_file"
# if $mine option ... make it mine
[[ $mine ]] && sudo chown "$current_user" "$new_file"
# convert
sudo plutil -convert "$option" "$new_file"
[[ "$?" ]] && printf "Conversion successful\n" || getout "$file" "Error converting to ${option} format : "
[[ "$?" ]] && printf "New file created.\n" || getout "$file" "Error renaming file. New file uses original name: "
printf '\n'
printf "${MAIN}${file} was converted to ${option} format. New filename: ${new_file}\n\n"
