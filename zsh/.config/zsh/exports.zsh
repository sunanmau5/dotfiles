# homebrew (prepend so it takes priority over /usr/bin)
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Global modules should live inside .local/
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export XDG_CONFIG_HOME="$HOME/.config"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# fzf
export FZF_DEFAULT_OPTS="--layout reverse"
export FZF_DEFAULT_COMMAND="fd $FD_OPTIONS --type f --strip-cwd-prefix"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
