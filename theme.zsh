COLOR_MAIN="109"
COLOR_ERROR="009"
COLOR_INFO="195"

function git_info() {
    local br="$(git_current_branch)"
    if [[ -n $br ]]; then
        echo "%F{$COLOR_INFO}$br%f"
    fi
}

function conda_info() {
    # only show info on non-base envs
    if [[ -n CONDA_DEFAULT_ENV && $CONDA_DEFAULT_ENV != "base" ]]; then
        echo "%F{$COLOR_INFO}$CONDA_DEFAULT_ENV%f"
    fi
}

local ret_status="%(?:%F{$COLOR_MAIN}:%F{$COLOR_ERROR})❯%f"
local current_path="%F{$COLOR_MAIN}%3~%f"

local nl=$'\n'
setopt prompt_subst

PROMPT='${nl}'
PROMPT+='${current_path} $(git_info) $(conda_info)'${nl}
PROMPT+='${ret_status} '
