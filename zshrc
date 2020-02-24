# Terminal

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LC_ALL=en_US.UTF-8
export ZSH="/Users/kamilogorek/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

setopt menu_complete # Autoselect first option on tab-completion

# Aliases

alias ls="ls -aG"
alias c="clear"
alias rp="source ~/.prompt"
alias update="brew update && brew upgrade && brew cleanup -s"
alias purge="curl -X PURGE"
alias cat="bat -p"
alias cdr="cd $(git rev-parse --show-toplevel 2> /dev/null)"

alias gs="git status"
alias gd="git diff"
alias ga="git commit --amend --no-edit"
alias wipe="git reset --hard && git clean -df"

alias tb="nc termbin.com 9999 | pbcopy"
alias yt="youtube-dl -f 'bestvideo[ext=mp4][height<=720]+bestaudio[ext=m4a]/best[ext=mp4][height<=720]/best'"

alias sentry-js-check="cd /Users/kamilogorek/Projects/sentry/sentry-javascript && rm -rf node_modules/ packages/*/node_modules && yarn && yarn clean && yarn build && yarn lint && yarn test"
alias sentry-link="yarn link @sentry/browser @sentry/node @sentry/apm @sentry/core @sentry/minimal @sentry/hub @sentry/types @sentry/utils @sentry/typescript @sentry/integrations"

# Functions

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

function batch-rename {
  local PATTERN="s/$1/$2/g"
  for i in ./* ; do mv $i $(echo $i | sed -e $PATTERN) ; done;
}

function what-is-listening {
  sudo lsof -iTCP -sTCP:LISTEN -n -P | grep ${1}
}

function kill-on-port {
  sudo lsof -iTCP -sTCP:LISTEN -n -P | grep ${1} | awk '{ print $2 }' | xargs kill -9;
}

# Packages
source `brew --prefix`/etc/profile.d/z.sh

# Python
source /usr/local/bin/virtualenvwrapper.sh

# JavaScript
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export PATH="$HOME/Projects/go/bin:$PATH"
export GOPATH="$HOME/Projects/go"