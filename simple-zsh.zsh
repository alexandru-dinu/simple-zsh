# add plugin-dirs to fpath
for p in $plugins; do
    fpath=($ZSH/plugins/$p $fpath)
done


## completion
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

## correction
alias cp='nocorrect cp'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias sudo='nocorrect sudo'

setopt correct_all


## history
function hist_wrap {
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

alias history='hist_wrap -i'

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data


## git
function __git_prompt_git() {
    GIT_OPTIONAL_LOCKS=0 command git "$@"
}

function git_current_branch() {
    local ref
    ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}

function git_commits_ahead() {
    if __git_prompt_git rev-parse --git-dir &>/dev/null; then
        local commits="$(__git_prompt_git rev-list --count @{upstream}..HEAD 2>/dev/null)"
        if [[ -n "$commits" && "$commits" != 0 ]]; then
            echo "$ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX$commits$ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX"
        fi
    fi
}

function git_commits_behind() {
    if __git_prompt_git rev-parse --git-dir &>/dev/null; then
        local commits="$(__git_prompt_git rev-list --count HEAD..@{upstream} 2>/dev/null)"
        if [[ -n "$commits" && "$commits" != 0 ]]; then
            echo "$commits"
        fi
    fi
}


# source plugins defined in .zshrc
for p in $plugins; do
    source $ZSH/plugins/$p/$p.plugin.zsh
done


# finally, source theme
autoload -Uz colors && colors
source $ZSH/theme.zsh
