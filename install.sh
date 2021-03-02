#!/usr/bin/env bash

# Color xtrace
oldPS4=$PS4
export PS4=$'+\e[33m $BASH_SOURCE:${BASH_LINENO[0]} \e[0m+  '

set -o xtrace

# Confirm that WSLENV is set correctly.
wslenv = 'WT_SESSION:USERPROFILE/p:APPDATA/p:LOCALAPPDATA/p:TMP/p:WT_PROFILE_ID'
if [[ "$WSLENV"  == "$wslenv" ]]; then
  errmsg="WSLENV not set correctly: Set WSLENV = $wslenv in Windows environment variables."
  echo -e "\033[0;31m$errmsg" 1>&2
  exit 126
fi

# Configuration support for the following WSL Distros and SSH ports.
# Exit for unknown distro.
declare -A wsl_distro_port=( ['Ubuntu']=2200 ['WLinux']=2201 )

if [[ ! ${wsl_distro_port[$WSL_DISTRO_NAME]+_} ]] ; then
  errmsg="$WSL_DISTRO_NAME does not have a port assigned.\n Edit install.sh"
  echo -e "\033[0;31m$errmsg" 1>&2
  exit 126
fi

sudo apt-get update         # Update package database

hash git || sudo apt-get install git
hash git-lfs || sudo apt-get install git-lfs

# rc (dotfiles) management
hash rcup || sudo apt-get install rcm

# Used by Vim
hash ctags || sudo apt install universal-ctags # Used by Gutentags in Vim
hash rg || sudo apt-get install ripgrep
hash gvim || sudo apt-get install vim-gtk3 # GUI Vim with python3
hash node || sudo apt-get install nodejs # Used by Coc.nvim
hash npm || sudo apt-get install npm # Used by Coc.nvim

hash tex || sudo apt-get install texlive-extra texlive-latex-extra texlive-xetex pandoc

[[ -f /usr/share/dict/american-english-huge ]] || sudo apt-get install wamerican-huge

# Used by shfmt and npiperelay
hash go || sudo apt-get install golang

# Used by ALE fixer for bash
hash shfmt || GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

# Used to access Windows OpenSSH's ssh-agent.
hash socat || sudo apt-get install socat

# Build and install npiperelay to use Windows OpenSSH's ssh-agent.
if [[ ! -z "${USERPROFILE}" ]]; then
  hash npiperelay.exe || \
  sudo ln -s $USERPROFILE/go/bin/npiperelay.exe \
      /usr/local/bin/npiperelay.exe || \
  ( GOOS=windows go get -d github.com/jstarks/npiperelay && \
    GOOS=windows go build -o $USERPROFILE/go/bin/npiperelay.exe \
      github.com/jstarks/npiperelay && \
    sudo ln -s $USERPROFILE/go/bin/npiperelay.exe \
        /usr/local/bin/npiperelay.exe
  )
else
  errmsg='Add USERPROFILE/p to the WSLENV Windows Environment Variable.\nThen Re-run install.sh'
  echo -e "\033[0;31m$errmsg" 1>&2
fi

# Avoid broken symlinks for removed files when running git pull on ~/.dotfiles.
[[ -e $HOME/.rcrc ]] && rcdn # Remove dotfiles managed by rcm

# Setup .dotfiles and run rcup to link configuration files.
[[ -d $HOME/.dotfiles/ ]] || git clone https://github.com/jfishe/dotfiles.git \
  $HOME/.dotfiles

pushd $HOME/.dotfiles

env RCRC=$HOME/.dotfiles/rcrc rcup # to copy/link dotfiles as specified in rcrc

git pull
git submodule update --init --recursive --remote
popd

# Setup symlink to $USERPROFILE for a new hostname.
# Most symlinks point to $USERPROFILE but some point to userprofile/Documents,
# which may break when Documents is not located on the Windows C:\ drive. Rcm
# ignores broken symlinks.
hostrcrc="host-`hostname`"
if [[ -d $HOME/.dotfiles/$hostrcrc ]]; then
  pushd $HOME/.dotfiles
  cp -r host-JOHN-AUD9AR3 $hostrcrc
  cd $hostrcrc
  rm userprofile
  ln -s $USERPROFILE userprofile
  popd
fi

env RCRC=$HOME/.dotfiles/rcrc rcup # to copy/link dotfiles as specified in rcrc
env RCRC=$HOME/.dotfiles/rcrc rcup # to link dotfiles symlinked to dotfiles


# Start sshd automatically using scripts developed by Pengwin.
pushd $HOME/.dotfiles

function cp_mod_own () {
  # $1: full path to destination, e.g. /etc/profile.d/start-ssh.sh
  # ${1:1}: relative path to source, e.g., etc/profile.d/start-ssh.sh
  # $2: permissions for $1
  sudo cp ${1:1} $1
  sudo chmod $2 $1
  sudo chown root.root $1
}

profile_d_start_ssh='/etc/profile.d/start-ssh.sh'
if [[ ! -f ${profile_d_start_ssh} ]] ; then
  cp_mod_own ${profile_d_start_ssh} 644
fi

bin_start_ssh='/usr/bin/start-ssh'
if [[ ! -f ${bin_start_ssh} ]] ; then
  cp_mod_own ${bin_start_ssh} 700
fi

sudoer_start_ssh='/etc/sudoers.d/start-ssh'
if [[ ! -f ${sudoer_start_ssh} ]] ; then
  visudo -c -q -f ${sudoer_start_ssh:1} && cp_mod_own ${sudoer_start_ssh} 0440
fi

ssh_config_d="/etc/ssh/sshd_config.d/${USER}.conf"
if [[ ! -f ${ssh_config_d} ]] ; then
  sudo sed -e "s/AllowUsers fishe/AllowUsers ${USER}/g" \
    -e "s/Port 2200/Port  ${wsl_distro_port[$WSL_DISTRO_NAME]}/g" \
    etc/ssh/sshd_config.d/fishe.conf > ${ssh_config_d}
  sudo chmod ${ssh_config_d} 644
  sudo chown root.root ${ssh_config_d}
  sudo service ssh --full-restart
fi
popd

# Update font cache
fc-cache -vf $HOME/.local/share/fonts

# Miniconda
if [[ ! -d "$HOME/miniconda3" ]]; then
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $TMP/miniconda.sh;
  bash $TMP/miniconda.sh -b
  rm $TMP/miniconda.sh
  $HOME/miniconda3/bin/conda init
  $HOME/miniconda3/bin/conda init zsh
fi

# Reset environment
set +o xtrace
PS4="$oldPS4"
unset oldPS4
