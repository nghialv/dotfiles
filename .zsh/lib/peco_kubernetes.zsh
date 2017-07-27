# Pick pod
function kpickpod {
  local pod=$(kubectl get pods | peco --prompt "[pods]" | awk '{print $1}')
  BUFFER="${BUFFER}${pod}"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N kpickpod
bindkey '^p' kpickpod

# Port forward
function kforward {
  local port="$1"

  if [ -z "$port" ] ; then
    echo "No port supplied."
    return
  fi

  local ports="$port"
  if [[ $port =~ "^[0-9]+$" ]] ; then
    ports="${port}:${port}"
  fi

  local pod=$(kubectl get pods | peco --prompt "[pods]" | awk '{print $1}')
  echo "kubectl port-forward ${pod} ${ports}"
  kubectl port-forward $pod $ports
}

# Logs
function klogs {
  local selected=$(kubectl get deployments,statefulset --no-headers | cut -d ' ' -f 1 | peco --query "$LBUFFER" | cut -d '/' -f 2)
  if [ -n "$selected" ]; then
    print -s "stern ${selected}" # register history
    stern ${selected}
  fi
}

# Context
function kctx() {
  local selected_context=$(kubectl config view -o go-template --template='{{range .contexts}}{{.name}}{{"\n"}}{{end}}' | peco --query "$LBUFFER")
  if [ -n "$selected_context" ]; then
    BUFFER="kubectl config use-context $selected_context"
    zle accept-line
  fi
  zle clear-screen
}
zle -N kctx
bindkey '^K' kctx
