# only export if not under TMUX
if [[ -z "$TMUX" ]]; then
    echo ''
fi

export LANG=en_US.UTF-8
export LC_ALL=$LANG

export ZSH=$HOME/.zsh/simple-zsh
export ZSH_CACHE_DIR=$HOME/.zsh/cache

# case-insensitive completion
# CASE_SENSITIVE="false"

# enable command auto-correction
# ENABLE_CORRECTION="true"

# display dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# timestamp format in history
# HIST_STAMPS="yyyy-mm-dd"

# plugin array
plugins=(zshmarks zsh-autosuggestions)

source $ZSH/simple-zsh.zsh
