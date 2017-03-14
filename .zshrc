# Path to my oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

autoload -U compinit
compinit -u

plugins=(git)

export LANG=en_US.UTF-8

# Set the default editor as Vim
export EDITOR=vim

export CODE=$HOME/Documents/code
export SRC=$CODE/src
export SDKS=$HOME/Documents/sdks

# PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Golang
export GOPATH=$CODE
export PATH=$PATH:/usr/local/Cellar/go/1.6.3/bin:$GOPATH/bin

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

# The next line updates PATH for the Google Cloud SDK
source $SDKS/google-cloud-sdk/path.zsh.inc

# The next line enables shell command completion for gcloud
source $SDKS/google-cloud-sdk/completion.zsh.inc

# Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Source other scripts
source ~/.zsh/lib/peco.zsh

function jcurl() {
  curl "$@" | python -m json.tool | pygmentize -l json
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
