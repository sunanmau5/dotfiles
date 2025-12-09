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

| Config                      | Description            |
| --------------------------- | ---------------------- |
| `zsh`                       | Shell configuration    |
| `nvim`                      | Neovim setup           |
| `ghostty`                   | Terminal emulator      |
| `starship`                  | Shell prompt           |
| `git`                       | Git configuration      |
| `karabiner`                 | Keyboard customization |
| `cursor` / `vscode` / `zed` | Editor settings        |

## Editor Setup

VSCode and Cursor store configs outside `~/.config`, so they need manual symlinks.

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

## Usage

Link everything:

```sh
stow */
```

Link one package:

```sh
stow nvim
```
