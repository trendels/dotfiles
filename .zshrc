# Setup emacs keybindings (e.g. Ctrl-A/Ctrl-E for beginning/end of line)
bindkey -e

alias cfg='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
alias ax='git annex'
alias ..='cd ..'
alias ls='ls -D "%Y-%m-%d %H:%M"'
alias ll='ls -lh'
alias la='ls -lha'
alias tree='tree -A'
alias ack='rg'

# Configure completions for homebrew packages
# See https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
export PATH="$PATH:/opt/homebrew/opt/util-linux/bin"
export PATH="$PATH:/opt/homebrew/opt/util-linux/sbin"

# Setup git prompt
source ~/.local/share/git/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1 # show unstaged (*) and staged (+) changes
export GIT_PS1_SHOWSTASHSTATE=1 # show stashed changes ($)
export GIT_PS1_SHOWUNTRACKEDFILES=1 # show untracked files (%) (can be slow)
export GIT_PS1_SHOWUPSTREAM="verbose" # show divergence from upstream as +/-
export GIT_PS1_STATESEPARATOR=" "
precmd () { __git_ps1 "%n@%m %1~" " %# " }

