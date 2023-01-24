export LC_ALL=en_US.UTF-8

# Load oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
ZSH_THEME="robbyrussell"
source "$ZSH/oh-my-zsh.sh"

# local dotfiles
source $HOME/dotfiles/paths
source $HOME/dotfiles/functions
source $HOME/dotfiles/aliases

# Autoselect first option on tab-completion
setopt no_menu_complete
# Show list of matches on second tab-complete
setopt auto_menu
# Color matched prefix on tab-complete
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==36=36}:${(s.:.)LS_COLORS}")'

# z - jump around - https://github.com/rupa/z
source `brew --prefix`/etc/profile.d/z.sh
# fzf - A command-line fuzzy finder - https://github.com/junegunn/fzf
export FZF_DEFAULT_COMMAND='fd'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# direnv - unclutter your .profile - https://github.com/direnv/direnv
eval "$(direnv hook zsh)"

export SENTRY_POST_MERGE_AUTO_UPDATE=1