#!/usr/bin/env bash

echo "Please install XCode from App Store, and then press ENTER"
open /Applications/App\ Store.app
read

echo "Please accept XCode license terms"
sudo xcodebuild -license

echo "Installing XCode Command Line Tools, press ENTER when done"
xcode-select --install > /dev/null 2>&1
read

echo "Symlinking dotfiles"
for file in ackrc aliases bash_profile editorconfig functions gitattributes gitconfig gitignore profile ssh tmux.conf vim vimrc 
do
    rm -rf ~/.$file
    ln -s ~/dotfiles/$file ~/.$file
done

echo "Installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade --all

echo "Installing homebrew packages"
for package in ack bash coreutils git httpie hub node tmux vim
do
    brew install $package
done
brew install vim --override-system-vi

brew cleanup

# Applications
#
# Chrome Canary
# Skype
# Slack
# Spotify
# Spectacle
# 1Password
# f.lux
