export TERM=xterm-256color

# Prompt

prompt_git_branch() {
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
		echo :\($branch\)
  fi
}

export PS1="\$(pwd)\$(prompt_git_branch) λ: "

# Aliases

alias ls="ls -aG"
alias c="clear"
alias rp="source ~/.prompt"
alias update="brew update && brew upgrade && brew cleanup -s"
alias purge="curl -X PURGE"

alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"
alias gd="git diff"
alias gdw="git diff -w --word-diff-regex=[^[:space:]]"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gco="git checkout"
alias ga="git commit --amend --no-edit"
alias wipe="git reset --hard && git clean -df"

alias g="grep-defaults"
alias ss="open -a ScreenSaverEngine"

# Functions

function what-is-listening {
  sudo lsof -iTCP -sTCP:LISTEN -n -P | grep ${1}
}

function kill-on-port {
  sudo lsof -iTCP -sTCP:LISTEN -n -P | grep ${1} | awk '{ print $2 }' | xargs -I {} kill -9 {};
}

function git-pr {
    branch=$(git rev-parse --abbrev-ref HEAD)
    remote=$(git remote -v | grep origin | grep \(push\) | awk -F ":" '{print $2}' | awk -F "/" '{print $1}')
    git commit -m ${1} && git push origin $branch && git pull-request -m ${1} -b $remote:develop -h $remote:$branch
}

function git-pr-fork {
    branch=$(git rev-parse --abbrev-ref HEAD)
    remote=$(git remote -v | grep upstream | grep \(push\) | awk -F ":" '{print $2}' | awk -F "/" '{print $1}')
    git commit -m ${1} && git push origin $branch && git pull-request -m ${1} -b $remote:develop -h kamilogorek:$branch
}

function git-clean {
    git branch -r --merged | grep ${1} | grep -v ${2} | awk -F "/" '{print $2}' | xargs -I {} git branch -D {}
}

function git-clean-pristine {
    git branch -r --merged | grep ${1} | grep -v ${2} | awk -F "/" '{print $2}' | xargs -I {} echo {}
}

function git-fix-dates {
    GIT_COMMITTER_DATE="`date`" git commit --amend --date="`date`"
}

function get-json {
    command="import json; import sys; from pprint import pprint; o = json.load(sys.stdin); pprint(o$3)"
    curl -s ${1} | python -c $command | grep ${2}
}

function grep-defaults {
    grep -rni --include \*.${3} ${1} ${2}
}

# Misc

stty -ixon # bind cltr+s for inverse ctrl+r search
shopt -s dotglob # include filenames beginning with a '.' in the results of pathname expansion

# Language specific

source `brew --prefix`/etc/profile.d/z.sh
source /usr/local/bin/virtualenvwrapper.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
