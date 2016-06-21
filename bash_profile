source `brew --prefix`/etc/profile.d/z.sh
source ~/.aliases
source ~/.functions

prompt_splitter() {
  echo "\e[48;5;161m $(printf "%*s" $(($(tput cols)-2)) "" | sed "s/ /-/g") \e[m"
}

prompt_date() {
  echo "[\D{%T}]"
}

prompt_cwd() {
  echo "[\w]"
}

prompt_git_branch() {
  echo "[\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)]"
}

# export PS1="\n$(prompt_splitter)\n\n$(prompt_date) | $(prompt_cwd) | $(prompt_git_branch) \nλ: "
export PS1="$(prompt_date) | $(prompt_cwd) | $(prompt_git_branch) \nλ: "

eval "$(rbenv init -)"

stty -ixon # bind cltr+s for inverse ctrl+r search
shopt -s dotglob # include filenames beginning with a '.' in the results of pathname expansion

. ~/dotfiles/git-completion.bash
. ~/dotfiles/npm-completion.bash

export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
