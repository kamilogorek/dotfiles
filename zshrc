export LC_ALL=en_US.UTF-8

# Load oh-my-zsh
plugins=(
  asdf
  brew
  fzf
  z
)
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export ZSH_THEME="robbyrussell"
source "$ZSH/oh-my-zsh.sh"

# Autoselect first option on tab-completion
setopt no_menu_complete
# Show list of matches on second tab-complete
setopt auto_menu
# Color matched prefix on tab-complete
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==36=36}:${(s.:.)LS_COLORS}")'

# atuin - Magical shell history - https://github.com/atuinsh/atuin
eval "$(atuin init zsh --disable-up-arrow)"

# Local dotfiles
source $HOME/dotfiles/aliases
source $HOME/dotfiles/functions
