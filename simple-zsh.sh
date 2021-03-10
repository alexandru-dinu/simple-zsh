# add plugin-dirs to fpath
for p in $plugins; do
    fpath=($ZSH/plugins/$p $fpath)
done

# source all lib configs
for cfg in $ZSH/lib/*.zsh; do
    source $cfg
done

# source plugins defined in .zshrc
for p in $plugins; do
    source $ZSH/plugins/$p/$p.plugin.zsh
done

# finally, source theme
source $ZSH/theme.zsh
