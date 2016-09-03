# Path to my oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

plugins=(git)

export LANG=en_US.UTF-8

# Set the default editor as Vim
export EDITOR=vim

export CODE=$HOME/Documents/code
export SDKS=$HOME/Documents/sdks

# PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Golang
export GOPATH=$CODE/go
export GO=/usr/local/Cellar/go16/1.6.3
export PATH=$PATH:$GO/bin:$GOPATH/bin

# Stack
export PATH=$PATH:~/.local/bin

# Haskell
#alias ghci="stack ghci"
#alias hdevtools="stack exec --no-ghc-package-path hdevtools --"

# Swiftenv
if which swiftenv > /dev/null; then
    eval "$(swiftenv init -)";
fi

# Rvm
export PATH="$PATH:$HOME/.rvm/bin"

# Terraform
export PATH=$PATH:/usr/local/terraform/bin:~/terraform

# Alias
alias ccode='cd $CODE'
alias cgo='cd $GOPATH'
alias cops='cd $CODE/ops'
alias cabema='cd $CODE/src/github.com/abema'
alias cme='cd $CODE/src/github.com/nghialv'

# The next line updates PATH for the Google Cloud SDK.
source $SDKS/google-cloud-sdk/path.zsh.inc

# The next line enables shell command completion for gcloud.
source $SDKS/google-cloud-sdk/completion.zsh.inc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
