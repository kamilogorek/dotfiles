export TERM=xterm-256color

source `brew --prefix`/etc/profile.d/z.sh
source ~/.aliases
source ~/.functions
source ~/.prompt

stty -ixon # bind cltr+s for inverse ctrl+r search
shopt -s dotglob # include filenames beginning with a '.' in the results of pathname expansion

# Language specific
. ~/dotfiles/git-completion.bash
. ~/dotfiles/npm-completion.bash

