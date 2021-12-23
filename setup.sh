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
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "=> Updating Homebrew"
brew update
brew upgrade

echo "=> Installing Homebrew packages"
for package in ag bat cask coreutils diff-so-fancy fd fzf git ncdu neovim tmux youtube-dl z zsh
do
    brew install $package
done

echo "=> Installing Cask apps"
for app in alacritty google-chrome rectangle visual-studio-code
do
    brew install --cask $app
done

echo "=> Installing Language specific software"

echo "=> Node"
brew install node

echo "=> Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "=> Clojure"
brew install --cask java
brew install leiningen
brew install clojure/tools/clojure

echo "=> Cleaning up"
brew cleanup

echo "=> Symlinking dotfiles"
for file in alacritty.yml aliases functions gitconfig hushlogin paths tmux.conf vimrc zshrc
do
    rm $HOME/.$file
    ln -s $HOME/dotfiles/$file $HOME/.$file
done
rm $HOME/Library/Application\ Support/Code/User/settings.json	
ln -s $HOME/dotfiles/vscode.json $HOME/Library/Application\ Support/Code/User/settings.json

echo "=> Installing vim-plug"
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

echo "=> Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "=> Installing p10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
p10k configure

echo "=> Symlinking p10k config"
rm $HOME/.p10k.zsh
ln -s $HOME/dotfiles/p10k $HOME/.p10k.zsh

echo "=> Installing fzf auto-completion and key bindings"
$(brew --prefix)/opt/fzf/install
