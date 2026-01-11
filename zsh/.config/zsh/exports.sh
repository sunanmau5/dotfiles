# homebrew
export PATH=$PATH:/opt/homebrew/bin

# Global modules should live inside .local/
export PATH="$HOME/.local/bin:$PATH"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

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

# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# fastlane
export LC_ALL=en_US.UTF-8