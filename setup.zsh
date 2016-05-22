#!/bin/sh

DF=$HOME/dotfiles

# Backup
DFBK=$HOME/.dotfiles_backup
if [ ! -d $DFBK ]; then
    mkdir $DFBK
fi

symlink(){
    local sourceFile=$1
    local targetFile=$2

    if [ -L $targetFile ]; then
        rm $targetFile
    elif [ -e $targetFile ]; then
        mv $targetFile $DFBK
        echo "moved $targetFile to $DFBK"
    fi
        
    ln -s $sourceFile $targetFile
    echo "linked $targetFile -> $sourceFile"
}

symlink_files() {
    local -a FILES=$(find $DF -type f -maxdepth 1 -name ".*" ! -name .DS_Store ! -name .git ! -name .gitignore \
        | sed "s/.*\/\(.*\)/\1/g")

    FILES="$FILES vim/.vimrc"
    
    for i in ${FILES[@]}; do
        sourceFile=$DF/$i
        targetFile=$HOME/$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")
        
        symlink $sourceFile $targetFile
    done
}

# Symblink dotfiles
symlink_files

# Vim
symlink $DF/vim/.vim $HOME/.vim

# Stack
symlink $DF/stack/config.yaml $HOME/.stack/config.yaml

source $HOME/.zshrc
echo "DONE!"
