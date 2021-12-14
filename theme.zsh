ZSH_COLOR_MAIN="cyan"
ZSH_COLOR_INFO="247"
ZSH_COLOR_DIRTY="red"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11"

# solarized dark colors for fzf
_gen_fzf_default_opts() {
    local base03="#002b36"
    local base02="#073642"
    local base01="#586e75"
    local base00="#657b83"
    local base0="#839496"
    local base1="#93a1a1"
    local base2="#eee8d5"
    local base3="#fdf6e3"
    local yellow="#b58900"
    local orange="#cb4b16"
    local red="#dc322f"
    local magenta="#d33682"
    local violet="#6c71c4"
    local blue="#268bd2"
    local cyan="#2aa198"
    local green="#859900"

    local colors="
        --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
        --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
    "
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} ${colors}"
}
_gen_fzf_default_opts

# prompt
_git_info () {
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

_conda_info () {
    # only show info on non-base envs
    if [[ -n "$CONDA_DEFAULT_ENV" && "$CONDA_DEFAULT_ENV" != "base" ]]; then
        echo "%F{$ZSH_COLOR_INFO}conda:$CONDA_DEFAULT_ENV%f "
    fi
}

PROMPT=$'\n'
PROMPT+='%F{$ZSH_COLOR_MAIN}%3~%f '
PROMPT+='$(_git_info)'
PROMPT+='$(_conda_info)'
PROMPT+=$'\n'
PROMPT+='%(?:%F{$ZSH_COLOR_MAIN}:%F{$ZSH_COLOR_DIRTY})${ZSH_PROMPT_ARROW:-❯}%f '
