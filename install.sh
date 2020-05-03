#!/usr/bin/env bash

# Color xtrace
local oldPS4=$PS4
export PS4=$'+\e[33m $BASH_SOURCE:${BASH_LINENO[0]} \e[0m+  '

set -o xtrace
sudo apt-get update         # Update package database

hash git || sudo apt-get install git
hash git-lfs || sudo apt-get install git-lfs

# rc (dotfiles) management
hash rcup || sudo apt-get install rcm

# Used by Vim
hash ctags || sudo apt install exuberant-ctags # Used by Gutentags in Vim
hash rg || sudo apt-get install ripgrep
hash gvim || sudo apt-get install vim-gtk3 # GUI Vim with python3

hash tex || sudo apt-get install texlive-full

# Used by shfmt in ALE fixer for bash
hash go || sudo apt-get install golang
hash shfmt || GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt


[[ -d ~/.dotfiles/ ]] || git clone https://github.com/jfishe/dotfiles.git ~/.dotfiles

pushd ~/.dotfiles
git pull
git submodule update --init --recursive --remote
popd

# env RCRC=~/.dotfiles/rcrc lsrc # to list dotfiles that would be changed
# echo ''
# echo 'env RCRC=~/.dotfiles/rcrc rcup # to copy/link dotfiles as specified in rcrc'
env RCRC=~/.dotfiles/rcrc rcup # to copy/link dotfiles as specified in rcrc
env RCRC=~/.dotfiles/rcrc rcup # to link dotfiles symlinked to dotfiles

# Update font cache
fc-cache -vf ~/.local/share/fonts

set +o xtrace
$PS4="$PS4"
unlet oldPS4
