#!/bin/zsh

export LC_ALL=en_US.UTF-8
# Load oh-my-zsh (ZSH env variable is required)
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
source "$ZSH/oh-my-zsh.sh"
# Load p10k
source "$HOME/.p10k.zsh"
# Autoselect first option on tab-completion
setopt no_menu_complete
# Show list of matches on second tab-complete
setopt auto_menu
# Color matched prefix on tab-complete
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==36=36}:${(s.:.)LS_COLORS}")'

# z - jump around - https://github.com/rupa/z
source `brew --prefix`/etc/profile.d/z.sh
# fzf - A command-line fuzzy finder - https://github.com/junegunn/fzf
source ~/.fzf.zsh
# direnv - unclutter your .profile - https://github.com/direnv/direnv
eval "$(direnv hook zsh)"

# local dotfiles
source ~/.aliases
source ~/.functions
source ~/.paths

