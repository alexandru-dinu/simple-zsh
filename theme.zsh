ZSH_COLOR_MAIN="cyan"
ZSH_COLOR_INFO="247"
ZSH_COLOR_DIRTY="203"

function _git_info() {
    local br="$(git_current_branch)"
    if [[ -n $br ]]; then
        if [[ $(git_is_dirty) = "true" ]]; then
            br+="%F{$ZSH_COLOR_DIRTY}*%f"
        fi
        echo "%F{$ZSH_COLOR_INFO}$br%f "
    fi
}

function _conda_info() {
    # only show info on non-base envs
    if [[ -n "$CONDA_DEFAULT_ENV" && "$CONDA_DEFAULT_ENV" != "base" ]]; then
        echo "%F{$ZSH_COLOR_INFO}($CONDA_DEFAULT_ENV)%f "
    fi
}

PROMPT=$'\n'
PROMPT+='%F{$ZSH_COLOR_MAIN}%3~%f '
[ $ZSH_ENABLE_GIT_INFO = "true" ] && PROMPT+='$(_git_info)'
[ $ZSH_ENABLE_CONDA_INFO = "true" ] && PROMPT+='$(_conda_info)'
PROMPT+=$'\n'
PROMPT+='%(?:%F{$ZSH_COLOR_MAIN}:%F{$ZSH_COLOR_DIRTY})${ZSH_PROMPT_ARROW:-❯}%f '
