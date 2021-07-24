# add plugin-dirs to fpath
for p in $plugins; do
    fpath=($ZSH_FRAMEWORK/plugins/$p $fpath)
done

zmodload zsh/complist
zmodload zsh/zle
autoload -Uz add-zsh-hook
autoload -Uz colors && colors

# use the default ls color theme
if [[ -z "$LS_COLORS" ]]; then
    (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi

unsetopt menu_complete      # do not autoselect the first completion entry
unsetopt flowcontrol        # disable start/stop flow control (^S/^Q)

setopt auto_menu            # show completion menu on successive tab press
setopt complete_in_word     # allow completion from within a word
setopt always_to_end        # move cursor to the end of the word on completion
setopt interactive_comments # allow comments
setopt auto_pushd           # make cd push the old dir onto the stack
setopt pushd_ignore_dups    # don't push multiple copies of the same dir
setopt pushdminus           # exchange the meaning of +/- when used with a number to specify a dir in the stack
setopt prompt_subst         # enable parameter expansion

if [[ "$ZSH_ENABLE_CASE_SENSITIVE" = "true" ]]; then
    zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$ZSH/cache"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

autoload -Uz compinit && compinit -u -C -d "$ZSH/zcompdump"
autoload -U +X bashcompinit && bashcompinit

if [[ "$ZSH_ENABLE_CORRECTION" = "true" ]]; then
    alias cp='nocorrect cp'
    alias man='nocorrect man'
    alias mkdir='nocorrect mkdir'
    alias mv='nocorrect mv'
    alias sudo='nocorrect sudo'

    setopt correct_all
fi

## history
function _hist_wrap() {
    local clear list
    zparseopts -E c=clear l=list

    if [[ -n "$clear" ]]; then
        # if -c provided, clobber the history file
        echo -n >| "$HISTFILE"
        fc -p "$HISTFILE"
        echo >&2 History file deleted.
    elif [[ -n "$list" ]]; then
        # if -l provided, run as if calling `fc' directly
        builtin fc "$@"
    else
        # unless a number is provided, show all history events (starting from 1)
        [[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
    fi
}
# timestamp: "yyyy-mm-dd"
alias history='_hist_wrap -i'

HISTFILE=${HISTFILE:-$ZSH/history}
HISTSIZE=1000000
SAVEHIST=1000000

## history options
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# keybindings
bindkey -M menuselect '^[[Z' reverse-menu-complete

if [[ "$ZSH_ENABLE_VI_MODE" = "true" ]]; then
    bindkey -v
    export KEYTIMEOUT=1

    bindkey '^a' beginning-of-line
    bindkey '^e' end-of-line
    bindkey '^r' history-incremental-search-backward
    bindkey '^s' history-incremental-search-forward
    bindkey '^?' backward-delete-char

    function zle-line-init zle-keymap-select {
        ZSH_PROMPT_ARROW="${${KEYMAP/vicmd/❮}/(main|viins)/❯}"
        zle reset-prompt
    }
    zle -N zle-line-init
    zle -N zle-keymap-select
fi

# async git info
source $ZSH_FRAMEWORK/git.zsh

# source plugins defined in .zshrc
for p in $plugins; do
    source $ZSH_FRAMEWORK/plugins/$p/$p.plugin.zsh
done

# source theme
source $ZSH_FRAMEWORK/theme.zsh

# nicer defaults
alias ls='ls --color=tty'
alias ll='ls -lah'
alias diff='diff --color'
alias grep='grep --color=auto --exclude-dir=.git'

# zshmarks
alias g="jump"
alias s="bookmark"
alias d="deletemark"
alias l="showmarks"
