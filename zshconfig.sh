export DOTFILES_PATH="$(cd "$(dirname "${(%):-%x}")" && pwd)"

export ZSH="$HOME/.oh-my-zsh"
export ZSH_TMUX_AUTOSTART=true

plugins=(zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export ALIAS_FILE_PATH="$DOTFILES_PATH/.zshrc_aliases.sh"

source $ALIAS_FILE_PATH

# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# homebrew
export PATH=$PATH:/opt/homebrew/bin

# Global modules should live inside .local/
export PATH="$HOME/.local/bin:$PATH"

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# https://reactnative.dev/docs/environment-setup
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PGUSER=postgres

# Docker
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

source $HOME/powerlevel10k/powerlevel10k.zsh-theme

# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# fastlane setup
export LC_ALL=en_US.UTF-8

# pyenv
export LANG=en_US.UTF-8export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# start tmux only for Alacritty
[ "$TERM" != alacritty ] || source $DOTFILES_PATH/tmux.sh

# zsh-autosuggestions config
bindkey '^ ' autosuggest-accept

# zoxide
eval "$(zoxide init zsh)"
