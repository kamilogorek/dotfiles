# Prevent play/pause button opening iTunes
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist
