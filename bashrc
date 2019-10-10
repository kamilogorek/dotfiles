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

eval "$(hub alias -s)"
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
alias fixaudio="sudo kextload /System/Library/Extensions/AppleHDA.kext"
alias tb="nc termbin.com 9999 | pbcopy"

alias dsn="echo https://363a337c11a64611be4845ad6e24f3ac@sentry.io/297378"
alias sentry-js-check="cd /Users/kamilogorek/Projects/sentry/sentry-javascript && rm -rf node_modules/ packages/*/node_modules && yarn && yarn clean && yarn build && yarn lint && yarn test"
alias sentry-link="yarn link @sentry/browser @sentry/node @sentry/core @sentry/minimal @sentry/hub @sentry/types @sentry/utils @sentry/typescript @sentry/integrations"

# Functions

function batch-rename {
  local PATTERN="s/$1/$2/g"
  for i in ./* ; do mv $i $(echo $i | sed -e $PATTERN) ; done;
}


function gl {
  if [[ $1 == "" ]]; then
    local LIMIT=20
  else
    local LIMIT=$1
  fi
  local HASH="%C(yellow)%h%C(reset)"
  local RELATIVE_TIME="%C(green)%ar%C(reset)"
  local AUTHORS="%C(bold blue)%an%C(reset)"
  local REFS="%C(red)%d%C(reset)"
  local SUBJECT="%s"
  local FORMAT="$HASH{$RELATIVE_TIME{$AUTHORS{$REFS $SUBJECT"
  git log --graph --color --pretty="tformat:$FORMAT" -$LIMIT | column -t -s '{' | less -FXRS
}

function what-is-listening {
  sudo lsof -iTCP -sTCP:LISTEN -n -P | grep ${1}
}

function kill-on-port {
  sudo lsof -iTCP -sTCP:LISTEN -n -P | grep ${1} | awk '{ print $2 }' | xargs kill -9;
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

# Packages specific

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

source `brew --prefix`/etc/profile.d/z.sh
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

source /usr/local/bin/virtualenvwrapper.sh

# JavaScript
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export PATH="$HOME/Projects/go/bin:$PATH"
export GOPATH="$HOME/Projects/go"


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash
