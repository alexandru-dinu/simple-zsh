autoload -Uz compinit && compinit
zmodload -i zsh/complist

unsetopt menu_complete  # do not autoselect the first completion entry
unsetopt flowcontrol    # disable start/stop flow control (^S/^Q)
setopt auto_menu        # show completion menu on successive tab press
setopt complete_in_word # allow completion from within a word
setopt always_to_end    # move cursor to the end of the word on completion

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit
