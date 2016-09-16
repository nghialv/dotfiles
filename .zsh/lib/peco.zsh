if ! which peco > /dev/null; then
  echo "You should install peco."
  return
fi

# Select git branch
alias -g B='`git branch | peco --prompt "[branch]" | sed -e "s/^\*[ ]*//g"`'

# Search history
function peco-select-history() {
  BUFFER=$(fc -l -r -n 1 | peco --prompt "[zsh history]" --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# Kill a processes
function peco-pkill() {
	for pid in `ps aux | peco --prompt "[kill ps]" | awk '{ print $2 }'`
	do
		kill $pid
		echo "Killed ${pid}"
	done
}
alias pk="peco-pkill"

# Cd a ghq directory
function peco-src() {
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
function peco-find-file() {
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
function peco-diff-files() {
  local source_files=$(git diff --name-status)
  local selected_files=$(echo $source_files | peco --prompt "[diff files]" | awk '{print $2}' | tr '\n' ' ')
  
  BUFFER="${BUFFER}${selected_files}"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N peco-diff-files
bindkey '^d' peco-diff-files

# Ag
function peco-ag-vim() {
  local query=$(echo $@ | tr ' ' '\n' | tail -1)
  vim $(ag --ignore-dir=.git $@ | peco --prompt "[ag vim]" --query $query | awk -F : '{print "-c " $2 " " $1}')
}
alias agv="peco-ag-vim"

# SSH
function peco-ssh() {
  local host=$(grep ^Host ~/.ssh/config | awk '{print $2}' | peco --prompt "[ssh]")

  if [ -n "$host" ]; then
    \ssh ${host}
  fi
}
alias pssh="peco-ssh"

# Docker peco
function peco-docker-search() {
  local term="$1"

  if ! [ -z "$term" ] ; then
    docker search $term | awk 'NR > 1' | peco --prompt "[docker search]" 2> /dev/null 
  fi
}
alias dsearch="peco-docker-search"

function peco-docker-images() {
    local args="$@"

    docker images $args | awk 'NR > 1' | peco --prompt "[images]" 2> /dev/null
}
alias dimages="peco-docker-images"

function peco-docker-push() {
  local images=$(peco-docker-images | awk '{print $1, $2}' | tr " " ":")

  for image in $images ; do
    echo docker push "$image"
    docker push "$image"
  done
}
alias dpush="peco-docker-push"

function peco-docker-rmi() {
  local arg="$1"
  local images=$(peco-docker-images -a | awk '{print $3}')

  for image in $images ; do
    echo docker rmi $arg "$image"
    docker rmi $arg "$image"
  done
}
alias drmi="peco-docker-rmi"

function peco-docker-ps() {
  local args="$@"

  docker ps $args | awk 'NR > 1' | peco --prompt "[docker ps]" 2> /dev/null 
}
alias dps="peco-docker-ps"

function peco-docker-start() {
  local containers=$(peco-docker-ps-stopped | awk 'BEGIN{ORS=" "}{print $1}')

  echo docker start $containers
  docker start $containers
}
alias dstart="peco-docker-start"

function peco-docker-stop() {
  local containers=$(peco-docker-ps | awk 'BEGIN{ORS=" "}{print $1}')

  echo docker stop $containers
  docker stop $containers
}
alias dstop="peco-docker-stop"

function peco-docker-kill() {
  local containers=$(peco-docker-ps | awk 'BEGIN{ORS=" "}{print $1}')

  echo docker kill $containers
  docker kill $containers
}
alias dkill="peco-docker-kill"

function peco-docker-ps-stopped() {
  local runnings=$(docker ps | awk 'NR > 1' | awk '{print $1}' | tr "\\n" "|")
  runnings=${runnings%%?}

  docker ps -a | awk 'NR > 1 && $1 !~ /^('"$runnings"')$/' | peco --prompt "[docker]" 2> /dev/null
}
alias dstopped="peco-docker-ps-stopped"

function peco-docker-rm() {
  local arg="$1"
  local containers=""

  if [ "$arg" = "-f" ] ; then
    containers=$(peco-docker-ps -a | awk '{print $1}')
  else 
    containers=$(peco-docker-ps-stopped | awk '{print $1}')
  fi

  for container in $containers ; do
    echo docker rm $arg "$container"
    docker rm $arg "$container"
  done
}
alias drm="peco-docker-rm"
