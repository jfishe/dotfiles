#!/usr/bin/env bash

# Color xtrace
oldPS4=$PS4
export PS4=$'+\e[33m $BASH_SOURCE:${BASH_LINENO[0]} \e[0m+  '

set -o xtrace

# Avoid broken symlinks for removed files when running git pull on ~/.dotfiles.
[[ -e $HOME/.rcrc ]] && rcdn # Remove dotfiles managed by rcm

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

# Used by shfmt and npiperelay
hash go || sudo apt-get install golang

# Used by ALE fixer for bash
hash shfmt || GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

# Used to access Windows OpenSSH's ssh-agent.
hash socat || sudo apt-get install socat

# Build and install npiperelay to use Windows OpenSSH's ssh-agent.
if [[ -z "${USERPROFILE}" ]]; then
  hash npiperelay.exe || go get -d github.com/jstarks/npiperelay && \
    GOOS=windows go build -o $USERPROFILE/go/bin/npiperelay.exe \
      github.com/jstarks/npiperelay && \
    sudo ln -s $USERPROFILE/go/bin/npiperelay.exe \
      /usr/local/bin/npiperelay.exe
else
  echo 'Add USERPROFILE/p to the WSLENV Windows Environment Variable.' 1>&2
  echo 'Then Re-run install.sh' 1>&2
fi

# Setup .dotfiles and run rcup to link configuration files.
[[ -d $HOME/.dotfiles/ ]] || git clone https://github.com/jfishe/dotfiles.git \
  $HOME/.dotfiles

pushd $HOME/.dotfiles
git pull
git submodule update --init --recursive --remote
popd

env RCRC=$HOME/.dotfiles/rcrc rcup # to copy/link dotfiles as specified in rcrc
env RCRC=$HOME/.dotfiles/rcrc rcup # to link dotfiles symlinked to dotfiles

# Update font cache
fc-cache -vf $HOME/.local/share/fonts

set +o xtrace
PS4="$oldPS4"
unset oldPS4
