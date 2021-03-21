# Simple zsh

[![CI](https://github.com/alexandru-dinu/simple-zsh/actions/workflows/main.yml/badge.svg)](https://github.com/alexandru-dinu/simple-zsh/actions/workflows/main.yml)

A minimalistic zsh framework combining ideas from [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) and [pure](https://github.com/sindresorhus/pure).


## Getting Started

### Prerequisites
- zsh 5.3+
- git 2.22+

### Install
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/alexandru-dinu/simple-zsh/main/install.sh)"
```


## Plugins

- Plugins can be added in the [plugins](https://github.com/alexandru-dinu/simple-zsh/tree/main/plugins) directory, each one having an entrypoint `X/X.plugin.zsh`.
- Enabling a plugin is done by adding it to the `plugins` array defined in `zshrc`.
- By default, [fzf](https://github.com/junegunn/fzf), [zshmarks](https://github.com/jocelynmallon/zshmarks) and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) are enabled.


## Performance
```
num  calls                time                       self            name
-----------------------------------------------------------------------------------
 1)    1          24.44    24.44   84.08%     24.44    24.44   84.08%  compinit
 2)    1           4.17     4.17   14.34%      4.17     4.17   14.34%  colors
 3)    1           0.26     0.26    0.90%      0.26     0.26    0.90%  add-zsh-hook
 4)    1           0.18     0.18    0.61%      0.18     0.18    0.61%  (anon)
 5)    1           0.02     0.02    0.07%      0.02     0.02    0.07%  bashcompinit
```
