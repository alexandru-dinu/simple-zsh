# Simple zsh

[![CI](https://github.com/alexandru-dinu/simple-zsh/actions/workflows/main.yml/badge.svg)](https://github.com/alexandru-dinu/simple-zsh/actions/workflows/main.yml)

 A minimalistic zsh configuration.

## Getting Started

### Prerequisites
- zsh 5.3+
- git 2.22+

### Install
```sh
SIMPLE_ZSH_DIR=$HOME/.zsh/simple-zsh

mkdir -p $SIMPLE_ZSH_DIR

git clone --depth=1 --recurse-submodules --remote-submodules \
    https://github.com/alexandru-dinu/simple-zsh.git $SIMPLE_ZSH_DIR

cp $SIMPLE_ZSH_DIR/zshrc.zsh $HOME/.zshrc

exec zsh -i -c "echo Done!; exit"
```

## Info
- Async git info using [async.zsh](https://github.com/mafredri/zsh-async).
- One clean theme, showing git and conda env info.
- Vi-mode is enabled by default.
- Plugins can be added in the [plugins](https://github.com/alexandru-dinu/simple-zsh/tree/main/plugins) directory, each one having an entrypoint `X/X.plugin.zsh`.
- Enabling a plugin is done by adding it to the `plugins` array defined in `zshrc`.
- The following plugins are enabled by default:
    - [fzf](https://github.com/junegunn/fzf) for fuzzy searching.
    - [zshmarks](https://github.com/jocelynmallon/zshmarks) for directory bookmarks.
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) for faster history completions.

## Credits
- Some sane defaults were inspired by [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) and [pure](https://github.com/sindresorhus/pure).
