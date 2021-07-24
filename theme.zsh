ZSH_COLOR_MAIN="cyan"
ZSH_COLOR_INFO="247"
ZSH_COLOR_DIRTY="red"

__git_info () {
    # no info to show (e.g. not inside a repo)
    [[ -z "$_GIT_INFO" ]] && return

    # parse info into a map
    declare -A info=( ${(@s: :)_GIT_INFO} )
    declare -A repr

    repr[branch]="%F{$ZSH_COLOR_INFO}$info[branch]%f"

    [[ $info[dirty] = "true" ]] && repr[dirty]="%F{$ZSH_COLOR_DIRTY}*%f"
    [[ $info[ahead] != "0" ]] && repr[ahead]="%F{$ZSH_COLOR_DIRTY}$info[ahead]↑%f"
    [[ $info[stash] != "0" ]] && repr[stash]="%F{$ZSH_COLOR_DIRTY}$info[stash]↴%f"

    local sepl="%F{$ZSH_COLOR_INFO}(%f"
    local sepr="%F{$ZSH_COLOR_INFO})%f"
    local symb=$( () { print -l "$*" } $repr[dirty] $repr[stash] $repr[ahead] )

    local out=$repr[branch]
    [[ -n $symb ]] && out+=$sepl$symb$sepr

    echo "$out "
}

__conda_info () {
    # only show info on non-base envs
    if [[ -n "$CONDA_DEFAULT_ENV" && "$CONDA_DEFAULT_ENV" != "base" ]]; then
        echo "%F{$ZSH_COLOR_INFO}(conda:$CONDA_DEFAULT_ENV)%f "
    fi
}

PROMPT=$'\n'
PROMPT+='%F{$ZSH_COLOR_MAIN}%3~%f '
[ $ZSH_ENABLE_GIT_INFO = "true" ] && PROMPT+='$(__git_info)'
[ $ZSH_ENABLE_CONDA_INFO = "true" ] && PROMPT+='$(__conda_info)'
PROMPT+=$'\n'
PROMPT+='%(?:%F{$ZSH_COLOR_MAIN}:%F{$ZSH_COLOR_DIRTY})${ZSH_PROMPT_ARROW:-❯}%f '
