zed="zed"
vscode="code"
cursor="cursor"
nvim="nvim"

export EDITOR=$zed

export ZSH_CONFIG_PATH="$HOME/.zshrc"
export ALIAS_FILE_PATH="$HOME/.config/zsh/aliases.sh"
export VSCODE_SETTINGS_PATH="$HOME/.config/vscode/settings.json"
export DEV_HOME="$HOME/Developer"
export DOTFILES_PATH="$HOME/.dotfiles"
export OBS_PATH="$HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/"
export VAULT_PATH="$OBS_PATH/vault"
export MENU_PATH="$OBS_PATH/cloud-storage"
export FD_PROFILE_PATH="$HOME/Library/Application\ Support/Firefox/Profiles/r84pvtib.dev-edition-default"

# tmux-sessionizer: directories to scan for projects (finds subdirs)
export PROJECT_DIRS="$DEV_HOME/projex $DEV_HOME/marta"
# tmux-sessionizer: specific paths shown directly in fzf (newline-separated)
export STANDALONE_PROJECTS="$DOTFILES_PATH
$VAULT_PATH
$MENU_PATH
$FD_PROFILE_PATH"

# Java version exports
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_17_HOME=$(/usr/libexec/java_home -v17)
export JAVA_22_HOME=$(/usr/libexec/java_home -v22)
export JAVA_24_HOME=$(/usr/libexec/java_home -v24)
