#!/bin/zsh

# Don't write .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

echo "=> Please install XCode from App Store, and then press ENTER"
open /System/Applications/App\ Store.app
read

echo "=> Installing XCode Command Line Tools, press ENTER when done"
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

echo "=> Accepting XCode license terms"
sudo xcodebuild -license accept

echo "=> Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/usr/local/bin/brew shellenv)"

echo "=> Updating Homebrew"
brew update
brew upgrade

echo "=> Installing Homebrew packages"
for package in ag atuin bat cask coreutils diff-so-fancy gh git fd ffmpeg fzf httpie jq kondo ncdu ngrok/ngrok/ngrok nvm orbstack vim yt-dlp/taps/yt-dlp z zsh
do
    brew install $package
done

echo "=> Installing Cask apps"
for app in google-chrome iterm2 rectangle visual-studio-code
do
    brew install --cask $app
done

echo "=> Installing Language specific software"

echo "=> Node.js"
nvm install --lts

echo "=> Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

echo "=> Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "=> Installing fzf auto-completion and key bindings"
$(brew --prefix)/opt/fzf/install --yes

echo "=> Installing vim-plug and vim plugins"
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

echo "=> Symlinking dotfiles"
for file in gitconfig gitignore vimrc zshrc
do
    rm $HOME/.$file
    ln -s $HOME/dotfiles/$file $HOME/.$file
done

echo "Changing iTerm default profile"
defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "/Users/kamilogorek/dotfiles"

echo "=> Supressing shell welcome banner with .hushlogin" | tee $HOME/.hushlogin

echo "=> Cleaning up"
brew cleanup
