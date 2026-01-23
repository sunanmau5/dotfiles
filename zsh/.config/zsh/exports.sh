# homebrew (prepend so it takes priority over /usr/bin)
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Global modules should live inside .local/
export PATH="$HOME/.local/bin:$PATH"

# react native
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# Docker
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# libpq (only set if installed, avoids breaking ruby builds)
if [[ -d "/opt/homebrew/opt/libpq" ]]; then
  export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
fi

# fastlane
export LC_ALL=en_US.UTF-8

# secrets
[[ -f "$HOME/.config/zsh/secrets.sh" ]] && source "$HOME/.config/zsh/secrets.sh"
