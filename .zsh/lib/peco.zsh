if ! which peco > /dev/null; then
  echo "You should install peco."
  return
fi

alias B='`git branch | peco --prompt "[branch]" | sed -e "s/^\*[ ]*//g"`'
alias P='| peco | xargs '

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
    selected_files=$(echo $source_files | peco --prompt "[find file]")

    BUFFER="${BUFFER}${echo $selected_files | tr '\n' ' '}"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-find-file
bindkey '^q' peco-find-file

# Docker peco
function peco-docker-images() {
    local args="$@"

    docker images $args | awk 'NR > 1' | peco 2> /dev/null
}


# Search a destination from cdr list
function peco-get-destination-from-cdr() {
	cdr -l | \
	sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
	peco --query "$LBUFFER"
}

# Search a destination from cdr list and cd the destination
function peco-cdr() {
	local destination="$(peco-get-destination-from-cdr)"
	if [ -n "$destination"  ]; then
		BUFFER="cd $destination"
		zle accept-line
	else
		zle reset-prompt
	fi
}
zle -N peco-cdr
bindkey '^x' peco-cdr
