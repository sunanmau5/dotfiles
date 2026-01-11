#!/bin/bash
# add cookie "Allow" exceptions to Firefox
# reads sites from cookie-sites.txt
# IMPORTANT: close firefox before running!

PROFILE_DIR="$(dirname "$0")"
DB="$PROFILE_DIR/permissions.sqlite"
SITES_FILE="$PROFILE_DIR/cookie-sites.txt"

# check if firefox is running
if pgrep -x "firefox" > /dev/null 2>&1 || pgrep -x "Firefox" > /dev/null 2>&1; then
    echo "ERROR: Close Firefox before running this script!"
    exit 1
fi

# check if database exists
if [ ! -f "$DB" ]; then
    echo "ERROR: permissions.sqlite not found"
    echo "       Start Firefox once first to create the database"
    exit 1
fi

# check if sites file exists
if [ ! -f "$SITES_FILE" ]; then
    echo "ERROR: cookie-sites.txt not found"
    exit 1
fi

echo "Adding cookie permissions from cookie-sites.txt..."
echo ""

count=0
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

    # insert permission (1 = ALLOW)
    sqlite3 "$DB" "INSERT OR REPLACE INTO moz_perms (origin, type, permission, expireType, expireTime, modificationTime)
                   VALUES ('$site', 'cookie', 1, 0, 0, $(date +%s)000);" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "  ✓ $site"
        ((count++))
    else
        echo "  ✗ $site (failed)"
    fi
done < "$SITES_FILE"

echo ""
echo "Done! Added $count site(s). Start Firefox to apply."
