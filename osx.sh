# Prevent play/pause button opening iTunes
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If you found this laptop, please call +48 691 661 695 or e-mail kamil.ogorek@gmail.com"
