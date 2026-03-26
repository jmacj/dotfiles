#!/usr/bin/env bash
# =============================================================================
# macos/defaults.sh  —  macOS system preference overrides
# Run manually: bash ~/dotfiles/macos/defaults.sh
# Requires macOS. Restart apps / log out for some changes to take effect.
# =============================================================================

set -euo pipefail

# Guard: this script only runs on macOS
if [[ "$(uname)" != "Darwin" ]]; then
  echo "ERROR: macos/defaults.sh is only for macOS. Exiting." >&2
  exit 1
fi

echo "Applying macOS defaults..."

# Close System Preferences to prevent it from overriding settings
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# ---- General ----------------------------------------------------------------
# Use dark menu bar and Dock
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# ---- Keyboard ---------------------------------------------------------------
# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# ---- Trackpad ---------------------------------------------------------------
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# ---- Finder -----------------------------------------------------------------
# Show filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keep folders on top in windows
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Default to home folder when opening new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# ---- Dock -------------------------------------------------------------------
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Remove auto-hide delay
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Icon size
defaults write com.apple.dock tilesize -int 48

# Don't show recent apps
defaults write com.apple.dock show-recents -bool false

# ---- Screenshots ------------------------------------------------------------
# Save to ~/Desktop/Screenshots
mkdir -p "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"

# Save as PNG
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# ---- Time Machine -----------------------------------------------------------
# Prevent Time Machine from prompting to use new hard drives as backup
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# ---- Safari -----------------------------------------------------------------
# Show full URL in address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable Debug menu and Inspect Element
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# ---- TextEdit ---------------------------------------------------------------
# Use plain text as default
defaults write com.apple.TextEdit RichText -int 0

# ---- Activity Monitor -------------------------------------------------------
# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# ---- Kill affected apps -----------------------------------------------------
for app in "Finder" "Dock" "SystemUIServer" "Safari"; do
  killall "$app" &>/dev/null || true
done

echo "Done. Some changes require a logout/restart."
