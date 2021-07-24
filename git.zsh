function __git_prompt_git() {
    GIT_OPTIONAL_LOCKS=0 command git "$@"
}

function git_current_branch() {
    local ref
    ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # not a git repo
        ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}

function git_is_dirty() {
    local ret=$(__git_prompt_git status --porcelain 2> /dev/null | tail -1)
    [[ -n $ret ]] && echo "true" || echo "false"
}

function git_commits_ahead() {
    if __git_prompt_git rev-parse --git-dir &>/dev/null; then
        local commits="$(__git_prompt_git rev-list --count @{upstream}..HEAD 2>/dev/null)"
        echo ${commits:-0}
    fi
}

function git_stash_count() {
    if __git_prompt_git rev-parse --git-dir &>/dev/null; then
        local count="$(__git_prompt_git stash list | wc -l)"
        echo ${count:-0}
    fi
}


source $ZSH_FRAMEWORK/async.zsh
async_init

_git_construct_info () {
    cd -q $1

    if ! __git_prompt_git rev-parse --git-dir &>/dev/null; then
        print ""
        return
    fi;

    declare -A info=(
        [branch]="$(git_current_branch)"
        [dirty]="$(git_is_dirty)"
        [ahead]="$(git_commits_ahead)"
        [stash]="$(git_stash_count)"
    )

    print ${(kv)info}
}

# callback function
_git_worker_callback() {
    _GIT_INFO=$3 # stdout
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
