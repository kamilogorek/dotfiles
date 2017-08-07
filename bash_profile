source `brew --prefix`/etc/profile.d/z.sh
source ~/.aliases
source ~/.functions

prompt_splitter() {
  echo "$(printf "%*s" $(tput cols) "" | cut -c 2- | sed "s/ /-/g")"
}

prompt_date() {
  echo "[\D{%T}]"
}

prompt_cwd() {
  echo "\W"
}

prompt_git_branch() {
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
		echo :\($branch\)
  fi
}

export PS1="$(prompt_splitter)\n$(prompt_cwd)\$(prompt_git_branch) λ: "

eval "$(rbenv init -)"

stty -ixon # bind cltr+s for inverse ctrl+r search
shopt -s dotglob # include filenames beginning with a '.' in the results of pathname expansion

. ~/dotfiles/git-completion.bash
. ~/dotfiles/npm-completion.bash

export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
