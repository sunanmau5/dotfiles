# Dotfiles

Personal configuration files for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/)

## Setup

```sh
# install command line tools
xcode-select --install

# clone repo with submodules
git clone --recurse-submodules git@github.com:sunanmau5/dotfiles.git ~/.dotfiles

# navigate to dotfiles
cd ~/.dotfiles

# install packages from Brewfile
brew bundle

# symlink all configs
stow */

# link shared Codex and Claude skills
./sskills/scripts/link-skills.sh
```

## What's Included

| Config                                   | Description                           |
| ---------------------------------------- | ------------------------------------- |
| `zsh`                                    | Shell configuration                   |
| `starship`                               | Shell prompt                          |
| `git`                                    | Git configuration                     |
| `mise`                                   | Version manager (node, ruby, etc)     |
| `tmux`                                   | Terminal multiplexer                  |
| `nvim`                                   | Neovim config                         |
| `alacritty` / `ghostty`                  | Terminal emulators                    |
| `less` / `ripgrep`                       | CLI tool defaults                     |
| `prettier`                               | Global Prettier defaults              |
| `lazygit`                                | Lazygit config                        |
| `btop`                                   | System monitor                        |
| `karabiner`                              | Keyboard customization                |
| `cursor` / `vscode` / `zed` / `opencode` | Editor settings                       |
| `codex`                                  | Codex skills                          |
| `claude`                                 | Claude Code settings                  |
| `sskills`                                | Shared Codex and Claude skills        |
| `docker`                                 | Docker CLI config                     |
| `firefox`                                | Arkenfox setup and cookie permissions |
| `obsidian`                               | Note-taking app                       |
| `datagrip`                               | DataGrip IdeaVim config               |

## Editor Setup

Most editors work automatically with stow, but VSCode and Cursor store configs outside `~/.config`, so they need manual symlinks

**VSCode:**

```sh
cd "$HOME/Library/Application\ Support/Code/User"
rm settings.json keybindings.json
ln -s $HOME/.config/vscode/settings.json .
ln -s $HOME/.config/vscode/keybindings.json .
```

**Cursor:**

```sh
cd "$HOME/Library/Application\ Support/Cursor/User"
rm settings.json keybindings.json
ln -s $HOME/.config/cursor/settings.json .
ln -s $HOME/.config/cursor/keybindings.json .
```

## Firefox (Arkenfox)

Privacy-hardened Firefox using [arkenfox user.js](https://github.com/arkenfox/user.js). Since Firefox profiles have random names, stow won't work, use the setup script instead

**Setup:**

```sh
# close Firefox first, then run setup (auto-detects all profiles)
~/.dotfiles/firefox/setupArkenfox.sh

# start Firefox once, close it, then add cookie permissions
~/.dotfiles/firefox/addCookiePermissions.sh
```

**What it does:**

| File                      | Description                           |
| ------------------------- | ------------------------------------- |
| `user-overrides.js`       | Personal prefs (symlinked to profile) |
| `cookie-sites.txt`        | Sites to stay logged in               |
| `setupArkenfox.sh`        | Downloads arkenfox & symlinks config  |
| `addCookiePermissions.sh` | Adds cookie exceptions to Firefox     |

Edit `cookie-sites.txt` to manage which sites keep cookies across sessions

## Claude Code

Claude Code settings are managed by the `claude` package and custom scripts

**Setup:**

```sh
# link Claude Code settings
stow claude

# sync Read permissions from variables.zsh
# run once after setup and whenever PROJECT_DIRS or STANDABLE_PROJECTS are updated
sync-claude-permissions
```

**What it does:**

| File / command            | Description                                 |
| ------------------------- | ------------------------------------------- |
| `~/.claude/settings.json` | Stowed Claude Code settings file            |
| `sync-claude-permissions` | Syncs Read permissions from `variables.zsh` |

## Tmux

On macOS, disable the system `C-Space` shortcut so tmux can receive the prefix:

**System Settings -> Keyboard -> Keyboard Shortcuts -> Input Sources** -> uncheck `Select the previous input source`.

## Zsh Secrets

The zsh config includes a `secrets.zsh.example` file. Copy it to create your own secrets file:

```sh
cp ~/.config/zsh/secrets.zsh.example ~/.config/zsh/secrets.zsh
```

## Usage

Link everything:

```sh
stow */
```

Link one package:

```sh
stow nvim
```
