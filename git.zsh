# Self-contained git utils

__git_prompt_git() {
    GIT_OPTIONAL_LOCKS=0 command git "$@"
}

git_is_repo () {
    __git_prompt_git rev-parse --git-dir &>/dev/null
    return $?
}

git_current_branch () {
    local ref
    ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # not a git repo
        ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}

git_is_dirty () {
    local ret=$(__git_prompt_git status --porcelain 2> /dev/null | tail -1)
    [[ -n $ret ]] && echo "true" || echo "false"
}

git_count_ahead () {
    if git_is_repo; then
        local commits=$(__git_prompt_git rev-list --count @{upstream}..HEAD 2>/dev/null)
        echo ${commits:-0}
    fi
}

git_count_stash () {
    if git_is_repo; then
        local count=$(__git_prompt_git stash list | wc -l)
        echo ${count:-0}
    fi
}


# Functions used by async worker
_git_construct_info () {
    cd -q $1

    # not inside a repo, return empty string to signal there's no git info to show
    if ! git_is_repo; then
        echo ""
        return
    fi

    declare -A info=(
        [branch]="$(git_current_branch)"
        [dirty]="$(git_is_dirty)"
        [ahead]="$(git_count_ahead)"
        [stash]="$(git_count_stash)"
    )

    echo ${(kv)info}
}

# callback function
_git_worker_callback() {
    local w_code=$2 w_stdout=$3

    # check return codes indicating an error
    # see https://github.com/mafredri/zsh-async/issues/42#issuecomment-716782220
    if (( w_code == 2 )) || (( w_code == 3 )) || (( w_code == 130 )); then
        async_stop_worker _git_worker
        async_start_worker _git_worker
        async_register_callback _git_worker _git_worker_callback
        async_job _git_worker _git_construct_info $PWD
    elif (( w_code )); then
        async_job _git_worker _git_construct_info $PWD
    fi

    _GIT_INFO=$w_stdout
    zle reset-prompt
}

# initialize the worker
async_start_worker _git_worker

# register callback for worker's completed jobs
async_register_callback _git_worker _git_worker_callback

# reschedule the job before prompt update
_git_worker_hook () {
    async_job _git_worker _git_construct_info $PWD
}
add-zsh-hook precmd _git_worker_hook
