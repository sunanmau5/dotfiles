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

## Usage

Link everything:

```sh
stow */
```

Link one package:

```sh
stow nvim
```
