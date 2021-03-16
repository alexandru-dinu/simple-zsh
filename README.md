# Simple zsh

[![CI](https://github.com/alexandru-dinu/simple-zsh/actions/workflows/main.yml/badge.svg)](https://github.com/alexandru-dinu/simple-zsh/actions/workflows/main.yml)

A minimalistic zsh framework combining ideas from [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) and [pure](https://github.com/sindresorhus/pure).


## Getting Started

### Prerequisites
- zsh 5.2+
- git 2.22+

### Install
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/alexandru-dinu/simple-zsh/main/install.sh)"
```


## Plugins

- Plugins can be added in the [plugins](https://github.com/alexandru-dinu/simple-zsh/tree/main/plugins) directory, each one having an entrypoint `X/X.plugin.zsh`.
- Enabling a plugin is done by adding it to the `plugins` array defined in `zshrc`.
- By default, [zshmarks](https://github.com/jocelynmallon/zshmarks) and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) are enabled.
- [fzf](https://github.com/junegunn/fzf#using-git) may be installed manually.
