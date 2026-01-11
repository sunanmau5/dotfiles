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

# zsh-autosuggestions config
bindkey '^ ' autosuggest-execute

# completions
autoload -Uz compinit
compinit

# rbenv
eval "$(rbenv init - zsh)"

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"
