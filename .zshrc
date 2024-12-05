# Setup emacs keybindings (e.g. Ctrl-A/Ctrl-E for beginning/end of line)
bindkey -e

# Changed to a shell wrapper to fix zsh completion, see ~/bin/cfg
#alias cfg='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
alias ax='git annex'
alias ..='cd ..'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -D "%Y-%m-%d %H:%M"'
alias ll='ls -lh'
alias la='ls -lha'
alias tree='tree -A'
alias ack='rg'
alias grep='grep --color=auto'
alias vicfg='nvim ~/.config/nvim/init.lua'

# See https://rye-up.com/guide/installation/#shell-completion
FPATH="$HOME/.zfunc:${FPATH}"

# Configure completions for homebrew packages
# See https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Load dynamic completions
source <(jj util completion zsh)

export PATH="$PATH:/opt/homebrew/opt/util-linux/bin"
export PATH="$PATH:/opt/homebrew/opt/util-linux/sbin"

# Setup git prompt
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1 # show unstaged (*) and staged (+) changes
export GIT_PS1_SHOWSTASHSTATE=1 # show stashed changes ($)
export GIT_PS1_SHOWUNTRACKEDFILES=1 # show untracked files (%) (can be slow)
export GIT_PS1_SHOWUPSTREAM="auto" # show divergence from upstream as <>
export GIT_PS1_STATESEPARATOR=" "

# Replacement for __git_ps1 that shows a jujutsu prompt if we're inside a
# jujutsu repository, or calls __git_ps1 otherwise. This is so that the git
# prompt is *not* show in colocated repositories.
#
# Only supports PROMPT_COMMAND (bash) or precmd() (zsh) mode (see documentation
# in git-prompt.sh)!
#
# Takes the same arguments as __git_ps1, the optional 4th argument is the
# format string for the jj status (default is to use the same as for git).
#
# Notes:
#
# - Does not work for git repositories nested inside jujutsu repositories (for
#   example in an ignored folder). In this case the jujutsu prompt will still
#   be shown even when inside the nested git repository.
#
# - Currenly only works with zsh (uses zsh-specific color codes)
#
__jj_ps1 () {
    # preserve exit status
    local exit=$?
    local printf_format=' (%s)'
    local git_printf_format=""
    local jj_printf_format=""

    case "$#" in
        2|3|4)
            ps1pc_start="$1"
            ps2pc_end="$2"
            git_printf_format="${3:-$printf_format}"
            jj_printf_format="${4:-$git_printf_format}"
            # set PS1 to a plain prompt so that we can
            # simply return early if the prompt should not
            # be decorated
            PS1="$ps1pc_start$ps2pc_end"
        ;;
        *) return $exit
        ;;
    esac

    local repo_root exit_code
    repo_root="$(jj root --ignore-working-copy 2>/dev/null)"

    # TODO also forward to __git_ps1 if we're inside an ignored directory!
    if [ -z "$repo_root" ]; then
        __git_ps1 "$ps1pc_start" "$ps2pc_end" "$git_printf_format"
    else
        local ch="$(jj log --ignore-working-copy --color=never --no-graph --template='change_id.shortest()' -r @ 2>/dev/null)"
        # Highlight change ID like the 'jj log' command (the actual color used
        # might depend on the jj configuration).
        local jjstring="%B%F{magenta}$ch%f%b"
        if [ "${__git_printf_supports_v-}" != yes ]; then
            jjstring=$(printf -- "$jj_printf_format" "$jjstring")
        else
            printf -v jjstring -- "$jj_printf_format" "$jjstring"
        fi
        PS1="$ps1pc_start$jjstring$ps2pc_end"
    fi

    return $exit
}

precmd () {
    # Setup terminal title
    title='%n@%m:%~'
    print -Pn "\e]2;${title}\a" # set window name
    print -Pn "\e]1;${title}\a" # set tab name

    # Setup jujutsu or git prompt
    __jj_ps1 "%F{green}%n@%m %F{blue}%1~%f%F{yellow}" " %f%# " " ⇌(%s)" " %s"
}

# Configure zsh
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt autocd

# Setup direnv
eval "$(direnv hook zsh)"
