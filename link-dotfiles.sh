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
for file in aliases bash_profile editorconfig functions gitattributes gitconfig gitignore profile prompt ssh tmux tmux.conf vim vimrc
do
    rm -rf ~/.$file
    ln -s ~/dotfiles/$file ~/.$file
done

echo "Installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade --all

echo "Installing homebrew packages"
for package in bash coreutils git httpie jq node reattach-to-user-namespace the_silver_searcher tmux vim z
do
    brew install $package
done
brew install vim --override-system-vi

brew tap caskroom/cask

echo "Installing cask packages"
for package in google-chrome slack spotify spectacle 1password
do
    brew install $package
done

brew cleanup

