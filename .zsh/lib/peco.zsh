if ! which peco > /dev/null; then
  echo "You should install peco."
  return
fi

# Select git branch
alias -g B='`git branch | peco --prompt "[branch]" | sed -e "s/^\*[ ]*//g"`'

# Search history
function peco-select-history {
  BUFFER=$(fc -l -r -n 1 | peco --prompt "[zsh history]" --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# Kill a processes
function peco-pkill {
	for pid in `ps aux | peco --prompt "[kill ps]" | awk '{ print $2 }'`
	do
		kill $pid
		echo "Killed ${pid}"
	done
}
alias pk="peco-pkill"

# Cd a ghq directory
function peco-src {
    local selected_dir=$(ghq list | peco --prompt "[ghq list]" --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${SRC}/${selected_dir}"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-src
stty -ixon
bindkey '^s' peco-src

# Open github page
alias gho='hub browse $(ghq list | peco --prompt "[hub browse]" | cut -d "/" -f 2,3)'

# Git ls-files
function peco-find-file {
    if git rev-parse 2> /dev/null; then
        source_files=$(git ls-files)
    else
        source_files=$(find . -type f)
    fi
    local selected_files=$(echo $source_files | peco --prompt "[find files]" | tr '\n' ' ')
    
    BUFFER="${BUFFER}${selected_files}"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-find-file
bindkey '^q' peco-find-file

# Git diff files
function peco-diff-files {
  local source_files=$(git diff --name-status)
  local selected_files=$(echo $source_files | peco --prompt "[diff files]" | awk '{print $2}' | tr '\n' ' ')
  
  BUFFER="${BUFFER}${selected_files}"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N peco-diff-files
bindkey '^d' peco-diff-files

# Ag
function peco-ag-vim {
  local query=$(echo $@ | tr ' ' '\n' | tail -1)
  local selected_file="$(ag --ignore-dir=.git $@ | peco --prompt "[ag vim]" --query $query | awk -F : '{print "-c " $2 " " $1}')"

  if [ -n "$selected_file" ] ; then
    vim $(echo $selected_file)
  fi
}
alias agv="peco-ag-vim"

# SSH
function peco-ssh {
  local host=$(grep ^Host ~/.ssh/config | awk '{print $2}' | peco --prompt "[ssh]")

  if [ -n "$host" ]; then
    \ssh ${host}
  fi
}
alias pssh="peco-ssh"

# Source files
source ~/.zsh/lib/peco_docker.zsh
source ~/.zsh/lib/peco_kubernetes.zsh
