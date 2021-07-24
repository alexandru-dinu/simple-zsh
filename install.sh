#!/bin/sh

# print each command and exit as soon as an error occurs
set -ex

SIMPLE_ZSH_DIR=$HOME/.zsh/simple-zsh

mkdir -p $SIMPLE_ZSH_DIR

git clone --depth=1 --recurse-submodules --remote-submodules \
    https://github.com/alexandru-dinu/simple-zsh.git $SIMPLE_ZSH_DIR

cp $SIMPLE_ZSH_DIR/zshrc.zsh $HOME/.zshrc

# only run if stdin is from a terminal
if [ -t 0 ]; then
    exec zsh -i -c "echo Done!; exit"
fi
