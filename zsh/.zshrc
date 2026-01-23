# load zap - zsh plugin manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# source - keep the order
plug "$HOME/.config/zsh/variables.sh"
plug "$HOME/.config/zsh/aliases.sh"
plug "$HOME/.config/zsh/functions.sh"
plug "$HOME/.config/zsh/exports.sh"

# plugins
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "jeffreytse/zsh-vi-mode"

# completions
autoload -Uz compinit
compinit

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# rbenv
eval "$(rbenv init - zsh)"

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# tmux (alacritty only)
# || true keeps exit code 0
[[ -z "$TMUX" && "$TERM_PROGRAM" == "Alacritty" ]] && tmux new-session -A -s main || true
