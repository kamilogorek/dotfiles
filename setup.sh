#!/usr/bin/env bash

echo "Please install XCode from App Store, and then press ENTER"
open /Applications/App\ Store.app
read

echo "Accepting XCode license terms"
sudo xcodebuild -license accept

echo "Installing XCode Command Line Tools, press ENTER when done"
xcode-select --install > /dev/null 2>&1
read

echo "Symlinking dotfiles"
for file in bash_profile bashrc gitconfig vimrc
do
    rm -rf ~/.$file
    ln -s ~/dotfiles/$file ~/.$file
done
 
echo "Installing Homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Updating Homebrew"
brew update
brew upgrade --all

echo "Installing Homebrew packages"
for package in ag bash bash-completion coreutils git hub node vim yarn z
do
    brew install $package
done

echo "Cleaning up Homebrew"
brew cleanup

echo "Installing VIM Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "Reload Bash"
exec bash
