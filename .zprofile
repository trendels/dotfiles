export EDITOR=/opt/homebrew/bin/nvim
export LANG="en_US.utf-8"
export LC_MONETARY="de_DE.utf-8"
export LC_TIME="de_DE.utf-8"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(direnv hook zsh)"

# Setting PATH for Python 3.11
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH

export PATH="${HOME}/bin:${PATH}"

# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH
