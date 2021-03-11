export LANG=en_US.UTF-8
export LC_ALL=$LANG

export ZSH=$HOME/.zsh/simple-zsh
export ZSH_CACHE_DIR=$HOME/.zsh/cache

CASE_SENSITIVE="false"
ENABLE_CORRECTION="true"

# plugin array
plugins=(zshmarks zsh-autosuggestions)

source $ZSH/simple-zsh.zsh
