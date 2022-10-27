# zsh config

[![CI](https://github.com/alexandru-dinu/zsh-config/actions/workflows/main.yml/badge.svg)](https://github.com/alexandru-dinu/zsh-config/actions/workflows/main.yml)

 A minimalistic zsh configuration.

## Getting Started

### Prerequisites
- zsh 5.3+
- git 2.22+

### Install

The config follows the [XDG Base Directory specification](https://wiki.archlinux.org/title/XDG_Base_Directory).
You need the following env vars defined in `~/.zshenv`:

```sh
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export HISTFILE="$XDG_DATA_HOME"/zsh/history
```

Then you can install the config as such:
```sh
CFG_DIR="$XDG_CONFIG_HOME"/zsh
DATA_DIR="$XDG_DATA_HOME"/zsh

rm -ri "$CFG_DIR"
mkdir -p "$DATA_DIR"

git clone --depth=1 --recurse-submodules --remote-submodules \
    https://github.com/alexandru-dinu/zsh-config.git $CFG_DIR
```

`$DATA_DIR` contains persistent, non-config files, e.g.:
```
bookmarks  history  zcompcache/  zcompdump
```

Finally, `config.zsh` needs to be sourced in `$ZDOTDIR/.zshrc`:
```sh
plugins=(fzf zshmarks zsh-autosuggestions)
source $ZDOTDIR/config.zsh
```

## Info
- Async git info using [async.zsh](https://github.com/mafredri/zsh-async).
- One clean theme, showing git and conda / venv info.
- Vi-mode is enabled by default.
- Plugins can be added in the [plugins](./plugins) directory, each one having an entrypoint `X/X.plugin.zsh`.
- Enabling a plugin is done by adding it to the `plugins` array defined in `zshrc`.
- The following plugins are enabled by default:
    - [fzf](https://github.com/junegunn/fzf) for fuzzy searching.
    - [zshmarks](https://github.com/jocelynmallon/zshmarks) for directory bookmarks.
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) for faster history completions.

## Credits
- Some sensible defaults were inspired by [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) and [pure](https://github.com/sindresorhus/pure).
