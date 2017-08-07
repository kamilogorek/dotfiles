source `brew --prefix`/etc/profile.d/z.sh
source ~/.aliases
source ~/.functions
source ~/.prompt

stty -ixon # bind cltr+s for inverse ctrl+r search
shopt -s dotglob # include filenames beginning with a '.' in the results of pathname expansion

. ~/dotfiles/git-completion.bash
. ~/dotfiles/npm-completion.bash

# Language specific

export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)

eval "$(rbenv init -)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
