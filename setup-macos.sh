#!/bin/bash

################################################################################
# System Preferences > Clock Menu Bar
################################################################################

# Clock > Show seconds
defaults write com.apple.menuextra.clock ShowSeconds -bool true


################################################################################
# System Preferences > Spotlight
################################################################################

# Hide Spotlight from menu bar
defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1


################################################################################
# System Preferences > Text Input
################################################################################

# Hide input menu from menu bar
defaults write com.apple.TextInputMenu visible -bool false


################################################################################
# System Preferences > Siri & Spotlight
################################################################################

# Siri > Hide from menu bar
defaults write com.apple.Siri SiriPrefStashedStatusMenuVisible -bool false

# Siri > Ask Siri
defaults write com.apple.Siri VoiceTriggerUserEnabled -bool false


################################################################################
# System Preferences > Desktop & Dock
################################################################################

# Remove all apps from Dock
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array

# Dock > Autohide
defaults write com.apple.dock autohide -bool true

# Dock > Hide recents
defaults write com.apple.dock "show-recents" -bool false

# Dock > Size
defaults write com.apple.dock tilesize -int 43

# Dock > Position
defaults write com.apple.dock orientation -string left

# Mission Control > Automatically rearrange Spaces
defaults write com.apple.dock mru-spaces -bool false

# Dock > Launch animation
defaults write com.apple.dock launchanim -bool false

# Windows & Apps > Prefer tabs when opening documents
defaults write -globalDomain AppleWindowTabbingMode -string "always"

# Desktop & Stage Manager > Click Wallpaper to reveal desktop
defaults write "com.apple.WindowManager" EnableStandardClickToShowDesktop -bool false


################################################################################
# System Preferences > Trackpad
################################################################################

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Pointer Control > Trackpad Options > Dragging Style: Three Finger Drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Trackpad speed
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "trackpad.speed" -float 3
defaults write com.apple.AppleMultitouchTrackpad "trackpad.speed" -float 3


################################################################################
# System Preferences > Sound
################################################################################

# Play feedback when volume is changed
defaults write -globalDomain "com.apple.sound.beep.feedback" -int 1


################################################################################
# System Preferences > Lock Screen
################################################################################

# Start Screen Saver when inactive: Never
defaults -currentHost write com.apple.screensaver idleTime -int 0


################################################################################
# System Preferences > Keyboard
################################################################################

# Swipe between pages: disabled
defaults write -g AppleEnableSwipeWithScrollBars -bool false

# Keyboard navigation
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false
defaults write -globalDomain AppleKeyboardUIMode -int 2

# Disable press-and-hold for diacritics
defaults write -g ApplePressAndHoldEnabled -bool false

# Txt Input > Correct spelling automatically
defaults write -globalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Txt Input > Capitalise words automatically
defaults write -globalDomain NSAutomaticCapitalizationEnabled -bool false

# Txt Input > Add full stop with double-space
defaults write -globalDomain NSAutomaticPeriodSubstitutionEnabled -bool false


################################################################################
# System Preferences > Appearance
################################################################################

defaults write -g AppleInterfaceStyle -string Dark

defaults write -g AppleLanguages -array en-US de-DE

defaults write -g AppleLocale -string "de-DE"

defaults write -g AppleMiniaturizeOnDoubleClick -bool false


################################################################################
# Finder > Preferences
################################################################################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show warning before removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

# Finder > View > As List
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder > iCloud Drive on Desktop
defaults write com.apple.finder FXICloudDriveDesktop -bool false

# Finder > Documents folder in iCloud Drive
defaults write com.apple.finder FXICloudDriveDocuments -bool false

# Finder > Show external hard drives on Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false

# Finder > Show hard drives on Desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false

# Finder > Show removable media on Desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Finder > Show recent tags
defaults write com.apple.finder ShowRecentTags -bool false


# Kill affected apps
for app in "Dock" "Finder"; do
	killall "${app}" > /dev/null 2>&1
done


# Done
echo "Done. Note that some of these changes require a logout/restart to take effect."
