# load zap - zsh plugin manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# source - keep the order
plug "$HOME/.config/zsh/variables.sh"
plug "$HOME/.config/zsh/aliases.sh"
plug "$HOME/.config/zsh/functions.sh"
plug "$HOME/.config/zsh/exports.sh"
[[ -f "$HOME/.config/zsh/secrets.sh" ]] && plug "$HOME/.config/zsh/secrets.sh"

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

# mise (version manager for node, ruby, python, java)
eval "$(mise activate zsh)"

# starship
# check that the function `starship_zle-keymap-select` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
    eval "$(starship init zsh)"
  }

# zoxide
eval "$(zoxide init zsh)"

# tmux (alacritty only)
# || true keeps exit code 0
[[ -z "$TMUX" && "$TERM_PROGRAM" == "Alacritty" ]] && tmux new-session -A -s main || true
