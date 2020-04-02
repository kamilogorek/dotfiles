#!/usr/bin/env zsh

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
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "=> Updating Homebrew"
brew update
brew upgrade

echo "=> Installing Homebrew packages"
for package in ag bat cask coreutils diff-so-fancy git rename vim youtube-dl z zsh
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
brew install node

echo "=> Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "=> Elixir"
brew install elixir

echo "=> Clojure"
brew cask install java
brew install leiningen
brew install clojure/tools/clojure

echo "=> Cleaning up"
brew cleanup

echo "=> Symlinking dotfiles"
for file in gitconfig hushlogin vimrc zshrc
do
    rm -rf ~/.$file
    ln -s ~/dotfiles/$file ~/.$file
done
rm -rf /Users/kamilogorek/Library/Application\ Support/Code/User/settings.json
ln -s ~/dotfiles/vscode.json /Users/kamilogorek/Library/Application\ Support/Code/User/settings.json

echo "=> Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

echo "=> Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "=> Installing p10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
p10k configure

echo "=> Symlinking p10k config"
rm -rf ~/.p10k.zsh
ln -s ~/dotfiles/p10k ~/.p10k.zsh
