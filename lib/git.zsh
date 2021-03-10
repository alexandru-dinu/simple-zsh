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
