COLOR_MAIN="109"
COLOR_ERROR="009"
COLOR_INFO="195"

function _git_info() {
    local br="$(git_current_branch)"
    if [[ -n $br ]]; then
        [[ $(git_is_dirty) = "true" ]] && br+="*"
        echo "%F{$COLOR_INFO}$br%f"
    fi
}

function _conda_info() {
    # only show info on non-base envs
    if [[ -n CONDA_DEFAULT_ENV && $CONDA_DEFAULT_ENV != "base" ]]; then
        echo "%F{$COLOR_INFO}$CONDA_DEFAULT_ENV%f"
    fi
}

PROMPT=$'\n'
PROMPT+='%F{$COLOR_MAIN}%3~%f '
[ $ENABLE_GIT_INFO = "true" ] && PROMPT+='$(_git_info) '
[ $ENABLE_CONDA_INFO = "true" ] && PROMPT+='$(_conda_info) '
PROMPT+=$'\n'
PROMPT+='%(?:%F{$COLOR_MAIN}:%F{$COLOR_ERROR})${PROMPT_ARROW:-❯}%f '
