# Get pod
function peco-kubernetes-get-pod() {
  local pod=$(kubectl get pods | peco --prompt "[pods]" | awk '{print $1}')

  BUFFER="${BUFFER}${pod}"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N peco-kubernetes-get-pod
bindkey '^p' peco-kubernetes-get-pod

# Port forward

function peco-kubernetes-port-forward() {
  local port="$1"

  if [ -z "$port" ] ; then
    echo "No port supplied."
    return
  fi

  local ports="$port"
  if [ $port =~ "^[0-9]+$" ] ; then
    ports="${port}:${port}"
  fi

  local pod=$(kubectl get pods | peco --prompt "[pods]" | awk '{print $1}')
  echo "kubectl port-forward ${pod} ${ports}"
  kubectl port-forward $pod $ports
}
alias kpf="peco-kubernetes-port-forward"

