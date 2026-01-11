#!/usr/bin/env bash

## cookie permissions script for arkenfox
## author: generated for user
## version: 1.0

## Adds cookie "Allow" exceptions to Firefox permissions.sqlite
## Reads sites from cookie-sites.txt in the same directory as this script

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
readonly SITES_FILE="$SCRIPT_DIR/cookie-sites.txt"

# Argument defaults
CONFIRM='yes'
PROFILE_PATH=false


show_banner() {
	echo -e "${BBLUE}
                ############################################################################
                ####                                                                    ####
                ####                   cookie permissions manager                       ####
                ####         Adds cookie exceptions to Firefox permissions.sqlite       ####
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
    -s           Silently add permissions. Do not seek confirmation."
	echo
	exit 1
}

#########################
#     File Handling     #
#########################

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
#   Firefox Check       #
#########################

fFF_check() {
	declare -r profile_dir="$1"
	declare -r lockfile="$profile_dir/lock"
	declare -r parentlock="$profile_dir/.parentlock"

	if [ -e "$lockfile" ] || [ -e "$parentlock" ]; then
		echo -e "\n${RED}This Firefox profile seems to be in use. Close Firefox and try again.${NC}\n" >&2
		return 1
	fi
	return 0
}

#########################
#  Permission Functions #
#########################

add_permissions_to_profile() {
	declare -r profile_dir="$1"
	declare -r profile_name=$(basename "$profile_dir")
	declare -r db="$profile_dir/permissions.sqlite"

	echo -e "\n${BBLUE}Adding permissions to:${NC} ${ORANGE}${profile_name}${NC}"

	# Check if Firefox is running
	if ! fFF_check "$profile_dir"; then
		return 1
	fi

	# Check if database exists
	if [ ! -f "$db" ]; then
		echo -e "${ORANGE}Warning: permissions.sqlite not found. Start Firefox once first.${NC}"
		return 1
	fi

	# Read sites and add permissions
	local count=0
	while IFS= read -r line || [ -n "$line" ]; do
		# skip empty lines and comments
		[[ -z "$line" || "$line" =~ ^# ]] && continue

		# trim whitespace
		site=$(echo "$line" | xargs)
		[[ -z "$site" ]] && continue

		# add https:// prefix if not present
		if [[ ! "$site" =~ ^https?:// ]]; then
			site="https://$site"
		fi

		# delete existing then insert (1 = ALLOW)
		sqlite3 "$db" "DELETE FROM moz_perms WHERE origin='$site' AND type='cookie';
		               INSERT INTO moz_perms (origin, type, permission, expireType, expireTime, modificationTime)
		               VALUES ('$site', 'cookie', 1, 0, 0, $(date +%s)000);" 2>/dev/null

		if [ $? -eq 0 ]; then
			echo -e "  ${GREEN}✓${NC} $site"
			((count++))
		else
			echo -e "  ${RED}✗${NC} $site (failed)"
		fi
	done < "$SITES_FILE"

	echo -e "\n${GREEN}Added $count site(s) to ${profile_name}${NC}"
}

#########################
#        Execute        #
#########################

# Check if running as root
if [ "${EUID:-"$(id -u)"}" -eq 0 ]; then
	echo -e "${RED}You shouldn't run this with elevated privileges (such as with doas/sudo).${NC}"
	exit 1
fi

# Check if sites file exists
if [ ! -f "$SITES_FILE" ]; then
	echo -e "${RED}Error: cookie-sites.txt not found at ${SITES_FILE}${NC}"
	exit 1
fi

# Check if sqlite3 is available
if ! command -v sqlite3 >/dev/null; then
	echo -e "${RED}Error: sqlite3 is required but not installed.${NC}"
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

echo -e "Reading sites from: ${CYAN}${SITES_FILE}${NC}\n"
echo -e "Sites to add:"
while IFS= read -r line || [ -n "$line" ]; do
	[[ -z "$line" || "$line" =~ ^# ]] && continue
	site=$(echo "$line" | xargs)
	[[ -z "$site" ]] && continue
	echo -e "  - $site"
done < "$SITES_FILE"
echo ""

getProfilePath # updates PROFILE_PATH if -l was used

# Add permissions to specific profile or auto-detect all
if [ "$PROFILE_PATH" != false ]; then
	# Specific profile
	if [ ! -d "$PROFILE_PATH" ]; then
		echo -e "${RED}Error: Profile directory not found: ${PROFILE_PATH}${NC}"
		exit 1
	fi

	if [ "$CONFIRM" = 'yes' ]; then
		echo -e "This will add cookie permissions to: ${ORANGE}${PROFILE_PATH}${NC}"
		echo -e "${RED}Continue Y/N?${NC}"
		read -p "" -n 1 -r
		echo -e "\n"
		[[ $REPLY =~ ^[Yy]$ ]] || { echo -e "${RED}Process aborted${NC}"; exit 0; }
	fi

	add_permissions_to_profile "$PROFILE_PATH"
else
	# Auto-detect all profiles
	PROFILES_ROOT=$(getProfilesRoot)

	if [ -z "$PROFILES_ROOT" ] || [ ! -d "$PROFILES_ROOT" ]; then
		echo -e "${RED}Error: Could not find Firefox profiles directory${NC}"
		echo -e "Please specify a profile path with -p or use -l to select from a list"
		exit 1
	fi

	echo -e "Auto-detecting Firefox profiles in: ${ORANGE}${PROFILES_ROOT}${NC}\n"

	# Find all profiles (directories containing prefs.js or times.json)
	profiles=()
	for profile_dir in "$PROFILES_ROOT"/*/; do
		if [ -d "$profile_dir" ] && { [ -f "$profile_dir/prefs.js" ] || [ -f "$profile_dir/times.json" ]; }; then
			profiles+=("${profile_dir%/}")
		fi
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
		echo -e "${RED}Add cookie permissions to all profiles? Y/N${NC}"
		read -p "" -n 1 -r
		echo -e "\n"
		[[ $REPLY =~ ^[Yy]$ ]] || { echo -e "${RED}Process aborted${NC}"; exit 0; }
	fi

	for profile_dir in "${profiles[@]}"; do
		add_permissions_to_profile "$profile_dir"
	done
fi

cd "$CURRDIR"

echo -e "\n${BBLUE}=========================================${NC}"
echo -e "${GREEN}All done!${NC}"
echo -e "${BBLUE}=========================================${NC}"
echo -e "\nStart Firefox to apply the changes."
