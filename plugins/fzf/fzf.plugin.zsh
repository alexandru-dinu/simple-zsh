FZF_ROOT_DIR=${FZF_ROOT_DIR:-$HOME/.fzf}
FZF_ZSH=$HOME/.fzf.zsh

if [[ ! -d $FZF_ROOT_DIR ]]; then
    echo "fzf is not installed in $FZF_ROOT_DIR. Installing..."
    git clone --depth=1 https://github.com/junegunn/fzf.git $FZF_ROOT_DIR
    $FZF_ROOT_DIR/install --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

export FZF_DEFAULT_OPS="--extended"

[ -f $FZF_ZSH ] && source $FZF_ZSH
