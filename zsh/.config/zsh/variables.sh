zed="zed"
vscode="code"
cursor="cursor"
nvim="nvim"

export EDITOR=$nvim

export ZSH_CONFIG_PATH="$HOME/.zshrc"
export ALIAS_FILE_PATH="$HOME/.config/zsh/aliases.sh"
export VSCODE_SETTINGS_PATH="$HOME/.config/vscode/settings.json"
export DEV_HOME="$HOME/Developer"
export DOTFILES_PATH="$HOME/.dotfiles"
export OBS_ICLOUD_PATH="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"
export OBS_LOCAL_PATH="$HOME/Documents/obsidian"
export VAULT_PATH="$OBS_PATH/vault"
export MENU_PATH="$OBS_ICLOUD_PATH/cloud-storage"
export FFD_PROFILE_PATH="$HOME/Library/Application Support/Firefox/Profiles/r84pvtib.dev-edition-default"

# common fd options
export FD_OPTIONS="--hidden --exclude '.git'"

# tmux-sessionizer
export PROJECT_DIRS="$DEV_HOME/marta $DEV_HOME/projex"
export STANDALONE_PROJECTS="$DOTFILES_PATH
$VAULT_PATH
$MENU_PATH
$FFD_PROFILE_PATH"
