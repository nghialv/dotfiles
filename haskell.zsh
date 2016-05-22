#!/bin/zsh

# Stack
brew install haskell-stack
stack setup

# Stylish-haskell
stack install slylish-haskell

# Hlint
stack install hlint

# Hoogle
stack install hoogle
hoogle data

# Ghc-mod
stack install ghc-mod

# Hdevtools
#stack install hdevtools

echo "DONE!"
