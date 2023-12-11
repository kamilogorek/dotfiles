export LC_ALL=en_US.UTF-8

unset ZSH_THEME
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
source "$ZSH/oh-my-zsh.sh"

PROMPT="%{$fg[yellow]%}%2~%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}]: %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ○"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Autoselect first option on tab-completion
setopt no_menu_complete
# Show list of matches on second tab-complete
setopt auto_menu
# Color matched prefix on tab-complete
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==36=36}:${(s.:.)LS_COLORS}")'


# brew - The missing package manager for macOS (or Linux) - https://github.com/Homebrew/brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# atuin - Magical shell history - https://github.com/atuinsh/atuin
eval "$(atuin init zsh --disable-up-arrow)"

# Node Version Manager - POSIX-compliant bash script to manage multiple active node.js versions
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source "$HOME/dotfiles/nvm-autoload"

# z - jump around - https://github.com/rupa/z
source `brew --prefix`/etc/profile.d/z.sh

# fzf - A command-line fuzzy finder - https://github.com/junegunn/fzf
# Use `fd` instead of `find` to respect .gitignore and strip cwd prefix from the output
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Local dotfiles
source $HOME/dotfiles/aliases
source $HOME/dotfiles/functions
source $HOME/dotfiles/paths

export NEXT_TELEMETRY_DISABLED=1
