#!/usr/bin/env bash

## arkenfox setup script for dotfiles
## author: generated for user
## version: 1.0

## Symlinks user-overrides.js from dotfiles to Firefox profile(s)
## and downloads the latest arkenfox user.js

## DON'T GO HIGHER THAN VERSION x.9 !! ( because of ASCII comparison )

readonly CURRDIR=$(pwd)

## get the full path of this script (readlink for Linux, greadlink for Mac with coreutils installed)
SCRIPT_FILE=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || greadlink -f "${BASH_SOURCE[0]}" 2>/dev/null)

## fallback for Macs without coreutils
[ -z "$SCRIPT_FILE" ] && SCRIPT_FILE=${BASH_SOURCE[0]}

readonly SCRIPT_DIR=$(dirname "${SCRIPT_FILE}")


#########################
#    Base variables     #
#########################

# Colors used for printing
RED='\033[0;31m'
BLUE='\033[0;34m'
BBLUE='\033[1;34m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Files
readonly OVERRIDES_FILE="$SCRIPT_DIR/user-overrides.js"

# Argument defaults
CONFIRM='yes'
PROFILE_PATH=false

# Download method priority: curl -> wget
DOWNLOAD_METHOD=''
if command -v curl >/dev/null; then
	DOWNLOAD_METHOD='curl --max-redirs 3 -so'
elif command -v wget >/dev/null; then
	DOWNLOAD_METHOD='wget --max-redirect 3 --quiet -O'
else
	echo -e "${RED}This script requires curl or wget.\nProcess aborted${NC}"
	exit 1
fi


show_banner() {
	echo -e "${BBLUE}
                ############################################################################
                ####                                                                    ####
                ####                     arkenfox dotfiles setup                        ####
                ####       Symlinks user-overrides.js and downloads arkenfox files      ####
                ####                                                                    ####
                ############################################################################"
	echo -e "${NC}\n"
}

#########################
#      Arguments        #
#########################

usage() {
	echo
	echo -e "${BLUE}Usage: $0 [-hls] [-p PROFILE]${NC}" 1>&2
	echo -e "
Optional Arguments:
    -h           Show this help message and exit.
    -p PROFILE   Path to your Firefox profile (if you want a specific one)
                 IMPORTANT: If the path contains spaces, wrap the entire argument in quotes.
    -l           Choose your Firefox profile from a list
    -s           Silently setup. Do not seek confirmation."
	echo
	exit 1
}

#########################
#     File Handling     #
#########################

download_file() { # expects URL as argument ($1)
	declare -r tf=$(mktemp)

	$DOWNLOAD_METHOD "${tf}" "$1" &>/dev/null && echo "$tf" || echo '' # return the temp-filename or empty string on error
}

readIniFile() { # expects one argument: absolute path of profiles.ini
	declare -r inifile="$1"

	if [ "$(grep -c '^\[Profile' "${inifile}")" -eq "1" ]; then ### only 1 profile found
		tempIni="$(grep '^\[Profile' -A 4 "${inifile}")"
	else
		echo -e "Profiles found:\n––––––––––––––––––––––––––––––"
		echo "$(grep --color=never -E 'Default=[^1]|\[Profile[0-9]*\]|Name=|Path=|^$' "${inifile}")"
		echo '––––––––––––––––––––––––––––––'
		read -p 'Select the profile number ( 0 for Profile0, 1 for Profile1, etc ) : ' -r
		echo -e "\n"
		if [[ $REPLY =~ ^(0|[1-9][0-9]*)$ ]]; then
			tempIni="$(grep "^\[Profile${REPLY}" -A 4 "${inifile}")" || {
				echo -e "${RED}Profile${REPLY} does not exist!${NC}" && exit 1
			}
		else
			echo -e "${RED}Invalid selection!${NC}" && exit 1
		fi
	fi

	declare -r pathisrel=$(sed -n 's/^IsRelative=\([01]\)$/\1/p' <<< "${tempIni}")
	PROFILE_PATH=$(sed -n 's/^Path=\(.*\)$/\1/p' <<< "${tempIni}")
	[[ ${pathisrel} == "1" ]] && PROFILE_PATH="$(dirname "${inifile}")/${PROFILE_PATH}"
}

getProfilePath() {
	declare -r f1=~/Library/Application\ Support/Firefox/profiles.ini
	declare -r f2=~/.mozilla/firefox/profiles.ini

	if [ "$PROFILE_PATH" = 'list' ]; then
		if [[ -f "$f1" ]]; then
			readIniFile "$f1"
		elif [[ -f "$f2" ]]; then
			readIniFile "$f2"
		else
			echo -e "${RED}Error: Sorry, -l is not supported for your OS${NC}"
			exit 1
		fi
	fi
}

getProfilesRoot() {
	if [[ "$OSTYPE" == "darwin"* ]]; then
		echo "$HOME/Library/Application Support/Firefox/Profiles"
	elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
		echo "$HOME/.mozilla/firefox"
	else
		echo ""
	fi
}

#########################
#    Setup Functions    #
#########################

setup_profile() {
	declare -r profile_dir="$1"
	declare -r profile_name=$(basename "$profile_dir")

	echo -e "\n${BBLUE}Setting up profile:${NC} ${ORANGE}${profile_name}${NC}"
	echo -e "Path: ${profile_dir}\n"

	cd "$profile_dir" || { echo -e "${RED}Error: Could not cd to profile${NC}"; return 1; }

	# download arkenfox files
	echo -e "Downloading ${CYAN}user.js${NC}..."
	declare -r newfile="$(download_file 'https://raw.githubusercontent.com/arkenfox/user.js/master/user.js')"
	[ -z "${newfile}" ] && echo -e "${RED}Error! Could not download user.js${NC}" && return 1
	mv "${newfile}" user.js
	echo -e "Status: ${GREEN}user.js downloaded${NC}"

	echo -e "Downloading ${CYAN}updater.sh${NC}..."
	declare -r updaterfile="$(download_file 'https://raw.githubusercontent.com/arkenfox/user.js/master/updater.sh')"
	[ -z "${updaterfile}" ] && echo -e "${RED}Error! Could not download updater.sh${NC}" && return 1
	mv "${updaterfile}" updater.sh
	chmod +x updater.sh
	echo -e "Status: ${GREEN}updater.sh downloaded${NC}"

	echo -e "Downloading ${CYAN}prefsCleaner.sh${NC}..."
	declare -r cleanerfile="$(download_file 'https://raw.githubusercontent.com/arkenfox/user.js/master/prefsCleaner.sh')"
	[ -z "${cleanerfile}" ] && echo -e "${RED}Error! Could not download prefsCleaner.sh${NC}" && return 1
	mv "${cleanerfile}" prefsCleaner.sh
	chmod +x prefsCleaner.sh
	echo -e "Status: ${GREEN}prefsCleaner.sh downloaded${NC}"

	# symlink user-overrides.js from dotfiles
	echo -e "Symlinking ${CYAN}user-overrides.js${NC}..."
	ln -sf "$OVERRIDES_FILE" "$profile_dir/user-overrides.js"
	echo -e "Status: ${GREEN}user-overrides.js symlinked${NC}"

	# run updater to merge overrides
	echo -e "Running ${CYAN}updater.sh${NC} to merge overrides..."
	./updater.sh -s -d

	echo -e "\n${GREEN}✓ Profile setup complete${NC}"
}

#########################
#        Execute        #
#########################

# Check if running as root
if [ "${EUID:-"$(id -u)"}" -eq 0 ]; then
	echo -e "${RED}You shouldn't run this with elevated privileges (such as with doas/sudo).${NC}"
	exit 1
fi

# Check if overrides file exists
if [ ! -f "$OVERRIDES_FILE" ]; then
	echo -e "${RED}Error: user-overrides.js not found at ${OVERRIDES_FILE}${NC}"
	exit 1
fi

# Parse arguments
if [ $# != 0 ]; then
	if [ "$1" = '--help' ] || [ "$1" = '-help' ]; then
		usage
	else
		while getopts ":hp:ls" opt; do
			case $opt in
				h)
					usage
					;;
				p)
					PROFILE_PATH=${OPTARG}
					;;
				l)
					PROFILE_PATH='list'
					;;
				s)
					CONFIRM='no'
					;;
				\?)
					echo -e "${RED}\n Error! Invalid option: -$OPTARG${NC}" >&2
					usage
					;;
				:)
					echo -e "${RED}Error! Option -$OPTARG requires an argument.${NC}" >&2
					exit 2
					;;
			esac
		done
	fi
fi

show_banner

getProfilePath # updates PROFILE_PATH if -l was used

# Setup specific profile or auto-detect all
if [ "$PROFILE_PATH" != false ]; then
	# Specific profile
	if [ ! -d "$PROFILE_PATH" ]; then
		echo -e "${RED}Error: Profile directory not found: ${PROFILE_PATH}${NC}"
		exit 1
	fi

	if [ "$CONFIRM" = 'yes' ]; then
		echo -e "This will setup arkenfox in: ${ORANGE}${PROFILE_PATH}${NC}"
		echo -e "${RED}Continue Y/N?${NC}"
		read -p "" -n 1 -r
		echo -e "\n"
		[[ $REPLY =~ ^[Yy]$ ]] || { echo -e "${RED}Process aborted${NC}"; exit 0; }
	fi

	setup_profile "$PROFILE_PATH"
else
	# Auto-detect all profiles
	PROFILES_ROOT=$(getProfilesRoot)

	if [ -z "$PROFILES_ROOT" ] || [ ! -d "$PROFILES_ROOT" ]; then
		echo -e "${RED}Error: Could not find Firefox profiles directory${NC}"
		echo -e "Please specify a profile path with -p or use -l to select from a list"
		exit 1
	fi

	echo -e "Auto-detecting Firefox profiles in: ${ORANGE}${PROFILES_ROOT}${NC}\n"

	# Find all profiles
	profiles=()
	for profile_dir in "$PROFILES_ROOT"/*.default*; do
		[ -d "$profile_dir" ] && profiles+=("$profile_dir")
	done

	if [ ${#profiles[@]} -eq 0 ]; then
		echo -e "${RED}No Firefox profiles found${NC}"
		exit 1
	fi

	echo -e "Found ${#profiles[@]} profile(s):"
	for p in "${profiles[@]}"; do
		echo -e "  - $(basename "$p")"
	done
	echo ""

	if [ "$CONFIRM" = 'yes' ]; then
		echo -e "${RED}Setup arkenfox in all profiles? Y/N${NC}"
		read -p "" -n 1 -r
		echo -e "\n"
		[[ $REPLY =~ ^[Yy]$ ]] || { echo -e "${RED}Process aborted${NC}"; exit 0; }
	fi

	for profile_dir in "${profiles[@]}"; do
		setup_profile "$profile_dir"
	done
fi

cd "$CURRDIR"

echo -e "\n${BBLUE}=========================================${NC}"
echo -e "${GREEN}Setup complete!${NC}"
echo -e "${BBLUE}=========================================${NC}"
echo -e "\nNext steps:"
echo -e "  1. Start Firefox"
echo -e "  2. Close Firefox"
echo -e "  3. Run: ${CYAN}~/.dotfiles/firefox/addCookiePermissions.sh${NC}"
echo -e "  4. Start Firefox again"
