set -e

SIMPLE_ZSH_DIR=$HOME/.zsh/simple-zsh

mkdir -p $SIMPLE_ZSH_DIR

git clone --depth=1 --recurse-submodules --remote-submodules \
    https://github.com/alexandru-dinu/simple-zsh.git $SIMPLE_ZSH_DIR

cp $SIMPLE_ZSH_DIR/zshrc.zsh $HOME/.zshrc

# run only if stdin refers to a terminal
if [ -t 0 ]; then
    exec zsh -l
else
    echo "Done. Run zsh manually."
fi
