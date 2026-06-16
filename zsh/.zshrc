# source - keep the order
source "$HOME/.config/zsh/options.zsh"
source "$HOME/.config/zsh/variables.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/exports.zsh"
[[ -f "$HOME/.config/zsh/secrets.zsh" ]] && source "$HOME/.config/zsh/secrets.zsh"

# completions
autoload -Uz compinit
compinit

# completion behavior
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' squeeze-slashes true

# history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# fzf
[[ -t 0 ]] && source <(fzf --zsh)

# mise (version manager for node, ruby, python, java)
eval "$(mise activate zsh)"

# starship
# check that the function `starship_zle-keymap-select` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null ||
  {
    eval "$(starship init zsh)"
  }

# zoxide
eval "$(zoxide init zsh)"

# zsh-autosuggestions
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# zsh-syntax-highlighting -- must be last
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# tmux (alacritty only)
# || true keeps exit code 0
[[ -z "$TMUX" && "$TERM_PROGRAM" == "Alacritty" ]] && tmux new-session -A -s main || true
