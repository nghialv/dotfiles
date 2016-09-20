#!/bin/sh

#echo "This script must be run in dotfiles directory."

DF=$PWD

# Backup
DFBK=$HOME/.dotfiles_backup
if [ ! -d $DFBK ]; then
    mkdir $DFBK
fi

function symlink {
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

function symlink_files {
    local -a FILES=$(find $DF -maxdepth 1 -name ".*" ! -name .DS_Store ! -name .git ! -name .gitignore \
        | sed "s/.*\/\(.*\)/\1/g")
    
    for i in ${FILES[@]}; do
        sourceFile=$DF/$i
        targetFile=$HOME/$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")
        
        symlink $sourceFile $targetFile
    done
}

# Symblink dotfiles
symlink_files

# Stack
symlink $DF/stack/config.yaml $HOME/.stack/config.yaml

# Peco
symlink $DF/.peco $HOME/.config/.peco

source $HOME/.zshrc
echo "DONE!"
