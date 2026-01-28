# Dotfiles

Personal configuration files for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```sh
# install command line tools
xcode-select --install

# clone repo
git clone git@github.com:sunanmau5/dotfiles.git ~/.dotfiles

# navigate to dotfiles
cd ~/.dotfiles

# install packages from Brewfile
brew bundle

# symlink all configs
stow */
```

## What's Included

| Config                                   | Description                       |
| ---------------------------------------- | --------------------------------- |
| `zsh`                                    | Shell configuration               |
| `nvim`                                   | Neovim setups                     |
| `alacritty` / `ghostty`                  | Terminal emulators                |
| `starship`                               | Shell prompt                      |
| `git`                                    | Git configuration                 |
| `karabiner`                              | Keyboard customization            |
| `cursor` / `vscode` / `zed` / `opencode` | Editor settings                   |
| `tmux`                                   | Terminal multiplexer              |
| `yazi`                                   | File manager                      |
| `obsidian`                               | Note-taking app                   |
| `scripts`                                | Custom scripts (tmux-sessionizer) |

## Editor Setup

Most editors work automatically with stow, but VSCode and Cursor store configs outside `~/.config`, so they need manual symlinks.

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

**Zed, Opencode, Obsidian:** These work automatically with stow since they use `~/.config`.

## Firefox (Arkenfox)

Privacy-hardened Firefox using [arkenfox user.js](https://github.com/arkenfox/user.js). Since Firefox profiles have random names, stow won't work — use the setup script instead.

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

Edit `cookie-sites.txt` to manage which sites keep cookies across sessions.

## Zsh Secrets

The zsh config includes a `secrets.sh.example` file. Copy it to create your own secrets file:

```sh
cp ~/.config/zsh/secrets.sh.example ~/.config/zsh/secrets.sh
```

Then edit `secrets.sh` with your actual values (API tokens, etc.). This file is gitignored and won't be committed.

## Usage

Link everything:

```sh
stow */
```

Link one package:

```sh
stow nvim
```
