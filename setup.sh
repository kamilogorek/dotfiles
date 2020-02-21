#!/usr/bin/env zsh

echo "=> Please install XCode from App Store, and then press ENTER"
open /System/Applications/App\ Store.app
read

echo "=> Installing XCode Command Line Tools, press ENTER when done"
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

echo "=> Accepting XCode license terms"
sudo xcodebuild -license accept

echo "=> Symlinking dotfiles"
for file in gitconfig hushlogin vimrc zshrc
do
    rm -rf ~/.$file
    ln -s ~/dotfiles/$file ~/.$file
done
 
echo "=> Installing Homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "=> Updating Homebrew"
brew update
brew upgrade

echo "=> Installing Homebrew packages"
for package in ag bat cask coreutils diff-so-fancy git vim youtube-dl z zsh
do
    brew install $package
done

echo "=> Installing Cask apps"
for app in google-chrome iterm2 visual-studio-code
do
    brew cask install $app
done

echo "=> Installing Language specific software"

echo "=> Node"
brew install yarn
curl https://get.volta.sh | zsh
volta install node

echo "=> Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "=> Cleaning up"
brew cleanup

echo "=> Installing VIM Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "=> Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
p10k configure
