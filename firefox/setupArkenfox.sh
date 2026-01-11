#!/bin/bash
# Arkenfox setup script for new machines
# Store this in your dotfiles along with:
#   - user-overrides.js
#   - cookie-sites.txt
#   - addCookiePermissions.sh
#
# Usage: ./setupArkenfox.sh /path/to/firefox/profile

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <firefox-profile-path>"
    echo ""
    echo "Find your profile path:"
    echo "  macOS: ~/Library/Application Support/Firefox/Profiles/*.default*"
    echo "  Linux: ~/.mozilla/firefox/*.default*"
    exit 1
fi

PROFILE_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$PROFILE_DIR" ]; then
    echo "ERROR: Profile directory not found: $PROFILE_DIR"
    exit 1
fi

echo "Setting up arkenfox in: $PROFILE_DIR"
echo ""

cd "$PROFILE_DIR"

# download arkenfox files
echo "Downloading arkenfox user.js..."
curl -sLO https://raw.githubusercontent.com/arkenfox/user.js/master/user.js

echo "Downloading updater.sh..."
curl -sLO https://raw.githubusercontent.com/arkenfox/user.js/master/updater.sh
chmod +x updater.sh

echo "Downloading prefsCleaner.sh..."
curl -sLO https://raw.githubusercontent.com/arkenfox/user.js/master/prefsCleaner.sh
chmod +x prefsCleaner.sh

# copy dotfiles
echo ""
echo "Copying your config files..."

for file in user-overrides.js cookie-sites.txt addCookiePermissions.sh; do
    if [ -f "$SCRIPT_DIR/$file" ]; then
        cp "$SCRIPT_DIR/$file" "$PROFILE_DIR/"
        echo "  ✓ $file"
    fi
done

chmod +x "$PROFILE_DIR/addCookiePermissions.sh" 2>/dev/null || true

# run updater to merge overrides
echo ""
echo "Running updater.sh to merge overrides..."
./updater.sh -s

echo ""
echo "========================================="
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Start Firefox (it will apply user.js)"
echo "  2. Close Firefox"
echo "  3. Run: ./addCookiePermissions.sh"
echo "  4. Start Firefox again"
echo "========================================="
