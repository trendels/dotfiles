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

precmd () {
    # Setup terminal title
    title='%n@%m:%~'
    print -Pn "\e]2;${title}\a" # set window name
    print -Pn "\e]1;${title}\a" # set tab name

    # Setup git prompt
    __git_ps1 "%n@%m %1~" " %# " " ⇌(%s)"
}

# Configure zsh
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt autocd
