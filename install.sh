set -ex

SIMPLE_ZSH_DIR=$HOME/.zsh/simple-zsh

mkdir -p $SIMPLE_ZSH_DIR

git clone --depth=1 --recurse-submodules --remote-submodules \
    https://github.com/alexandru-dinu/simple-zsh.git $SIMPLE_ZSH_DIR

cp $SIMPLE_ZSH_DIR/zshrc.zsh $HOME/.zshrc

exec zsh -i -c "echo Done!; exit"
