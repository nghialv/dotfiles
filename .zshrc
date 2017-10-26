# Path to my oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

export PS1="🐳  $PS1"

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
export GOROOT=/usr/local/go1.9.2
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

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

# Istio
export PATH=$PATH:~/.istio

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

# Make pet able to capture the previous command
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zsh/lib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh/lib/zsh-history-substring-search/zsh-history-substring-search.zsh

# # Enable vi mode
# bindkey -v

# bindkey '^P' up-history
# bindkey '^N' down-history
# bindkey '^?' backward-delete-char
# bindkey '^h' backward-delete-char
# bindkey '^w' backward-kill-word
# bindkey '^r' history-incremental-search-backward

# export KEYTIMEOUT=1

# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
