# Docker peco
function peco-docker-search {
  local term="$1"

  if ! [ -z "$term" ] ; then
    docker search $term | awk 'NR > 1' | peco --prompt "[docker search]" 2> /dev/null 
  fi
}
alias dsearch="peco-docker-search"

function peco-docker-images {
    local args="$@"

    docker images $args | awk 'NR > 1' | peco --prompt "[images]" 2> /dev/null
}
alias dimages="peco-docker-images"

function peco-docker-push {
  local images=$(peco-docker-images | awk '{print $1, $2}' | tr " " ":")

  for image in $images ; do
    echo docker push "$image"
    docker push "$image"
  done
}
alias dpush="peco-docker-push"

function peco-docker-rmi {
  local arg="$1"
  local images=$(peco-docker-images -a | awk '{print $3}')

  for image in $images ; do
    echo docker rmi $arg "$image"
    docker rmi $arg "$image"
  done
}
alias drmi="peco-docker-rmi"

function peco-docker-ps {
  local args="$@"

  docker ps $args | awk 'NR > 1' | peco --prompt "[docker ps]" 2> /dev/null 
}
alias dps="peco-docker-ps"

function peco-docker-start {
  local containers=$(peco-docker-ps-stopped | awk 'BEGIN{ORS=" "}{print $1}')

  echo docker start $containers
  docker start $containers
}
alias dstart="peco-docker-start"

function peco-docker-stop {
  local containers=$(peco-docker-ps | awk 'BEGIN{ORS=" "}{print $1}')

  echo docker stop $containers
  docker stop $containers
}
alias dstop="peco-docker-stop"

function peco-docker-kill {
  local containers=$(peco-docker-ps | awk 'BEGIN{ORS=" "}{print $1}')

  echo docker kill $containers
  docker kill $containers
}
alias dkill="peco-docker-kill"

function peco-docker-ps-stopped {
  local runnings=$(docker ps | awk 'NR > 1' | awk '{print $1}' | tr "\\n" "|")
  runnings=${runnings%%?}

  docker ps -a | awk 'NR > 1 && $1 !~ /^('"$runnings"')$/' | peco --prompt "[docker]" 2> /dev/null
}
alias dstopped="peco-docker-ps-stopped"

function peco-docker-rm {
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
