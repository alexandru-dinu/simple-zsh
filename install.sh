set -e

SIMPLE_ZSH_DIR=$HOME/.zsh/simple-zsh

mkdir -p $SIMPLE_ZSH_DIR

git clone --depth=1 --recurse-submodules --remote-submodules \
    https://github.com/alexandru-dinu/simple-zsh.git $SIMPLE_ZSH_DIR

cp $SIMPLE_ZSH_DIR/zshrc.zsh $HOME/.zshrc

# TODO: add RUNSH var, don't do it by default
exec zsh -l
