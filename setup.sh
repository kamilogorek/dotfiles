#!/bin/zsh

# Don't write .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
# Disable emoji sugestions
defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist emoji_enhancements -dict-add Enabled -bool NO

echo "=> Please install XCode from App Store, and then press ENTER"
open /System/Applications/App\ Store.app
read

echo "=> Installing XCode Command Line Tools, press ENTER when done"
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

echo "=> Accepting XCode license terms"
sudo xcodebuild -license accept

echo "=> Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "=> Updating Homebrew"
brew update
brew upgrade

echo "=> Installing Homebrew packages"
for package in ag atuin bat cask coreutils curl diff-so-fancy eza gh git fd ffmpeg fzf httpie jq kondo n ncdu neovim ngrok/ngrok/ngrok vim yt-dlp/taps/yt-dlp z zsh
do
    brew install $package
done

echo "=> Installing Cask apps"
for app in ghostty google-chrome karabiner-elements orbstack rectangle zed
do
    brew install --cask $app
done

echo "=> Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

echo "=> Symlinking dotfiles"
for file in gitconfig gitignore vimrc zshrc
do
    rm $HOME/.$file 2> /dev/null
    ln -s $HOME/dotfiles/$file $HOME/.$file
done

echo "=> Symlinking configs"
mkdir -p $home/.config
for dir in atuin ghostty karabiner nvim zed
do
    rm $HOME/.config/$dir 2> /dev/null
    ln -s $HOME/dotfiles/$dir $HOME/.config
done

echo "=> Installing vim-plug and vim plugins"
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

echo "=> Supressing shell welcome banner with .hushlogin" | tee $HOME/.hushlogin

echo "=> Cleaning up"
brew cleanup
