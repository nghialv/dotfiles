export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

plugins=(git)

# Set the default editor as Vim
export EDITOR=vim

# PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Rvm
export PATH="$PATH:$HOME/.rvm/bin"

# Go lang
export GOPATH=$HOME/Documents/go/workspace
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Add Stack to PATH
export PATH=$PATH:~/.local/bin

# Haskell
#alias ghci="stack ghci"
#alias hdevtools="stack exec --no-ghc-package-path hdevtools --"

# Swiftenv
if which swiftenv > /dev/null; then
    eval "$(swiftenv init -)";
fi
