#!/usr/bin/env bash

# Color xtrace
oldPS4="$PS4"
export PS4="$'+\e[33m $BASH_SOURCE:${BASH_LINENO[0]} \e[0m+  '"

TMP="$(mktemp -d)"

# Print commands and their arguments as they are executed.
set -o xtrace
# Exit immediately if a command exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the status of the last command to exit with
# a non-zero status, or zero if no command exited with a non-zero status
set -o pipefail

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap \
  '{ echo "\"${last_command}\" command filed with exit code $?." ;
  /usr/bin/rm -r "${TMP}" ;
  # Reset environment
  set +x +e +o pipefail ;
  PS4="$oldPS4"
  unset oldPS4 TMP
  }' \
  SIGINT SIGTERM ERR EXIT

# Confirm that WSLENV is set correctly.
declare wslenv = 'WT_SESSION:USERPROFILE/p:APPDATA/p:LOCALAPPDATA/p:TMP/p:WT_PROFILE_ID'
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

sudo apt update         # Update package database

hash git || sudo apt install git
hash git-lfs || sudo apt install git-lfs

# Msysgit /etc/gitattributes sets astextplain as an executable.
# .dotfiles/.gitconfig includes [diff "astextplain"]
# run-mailcap --action=cat <file>
# https://github.com/msysgit/msysgit/blob/master/bin/astextplain
hash docx2txt || sudo apt install docx2txt
hash antiword || sudo apt install antiword
hash pdftotext || sudo apt install poppler-utils

# rc (dotfiles) management
hash rcup || sudo apt install rcm

# Used by Vim
hash ctags || sudo apt install universal-ctags # Used by Gutentags in Vim
hash rg || sudo apt install ripgrep
hash pandoc || sudo apt install pandoc
hash gvim || sudo apt install vim-gtk3 # GUI Vim with python3
hash node || sudo apt install nodejs # Used by Coc.nvim
hash npm || sudo apt install npm # Used by Coc.nvim

# Used by Vimwiki
# https://github.com/tools-life/taskwiki
hash task || sudo apt install taskwarrior python3-tasklib tasksh

# Try Ubuntu first and then Debian
# https://wiki.debian.org/Latex
# https://tug.org/texlive/debian.html
hash tex || sudo apt install texlive texlive-latex-extra texlive-xetex

[[ -f /usr/share/dict/american-english-huge ]] || sudo apt install wamerican-huge

# Used by shfmt and npiperelay
hash go || sudo apt install golang

# Used by ALE fixer for bash
hash shfmt || GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

# Used to access Windows OpenSSH's ssh-agent.
hash socat || sudo apt install socat

# Build and install npiperelay to use Windows OpenSSH's ssh-agent.
if [[ ! -z "${USERPROFILE}" ]]; then
  hash npiperelay.exe || \
  sudo ln -s "$USERPROFILE/go/bin/npiperelay.exe" \
      /usr/local/bin/npiperelay.exe || \
  ( GOOS=windows go get -d github.com/jstarks/npiperelay && \
    GOOS=windows go build -o "$USERPROFILE/go/bin/npiperelay.exe" \
      github.com/jstarks/npiperelay && \
    sudo ln -s "$USERPROFILE/go/bin/npiperelay.exe" \
        /usr/local/bin/npiperelay.exe
  )
else
  errmsg='Add USERPROFILE/p to the WSLENV Windows Environment Variable.\nThen Re-run install.sh'
  echo -e "\033[0;31m$errmsg" 1>&2
fi

# Avoid broken symlinks for removed files when running git pull on ~/.dotfiles.
[[ -e "$HOME/.rcrc" ]] && rcdn # Remove dotfiles managed by rcm

# Setup .dotfiles and run rcup to link configuration files.
[[ -d "$HOME/.dotfiles/" ]] || git clone https://github.com/jfishe/dotfiles.git \
  "$HOME/.dotfiles"

pushd "$HOME/.dotfiles"

env RCRC="$HOME/.dotfiles/rcrc" rcup -v # to copy/link dotfiles as specified in rcrc

git pull
git submodule update --init --recursive --remote
popd

# Setup symlink to $USERPROFILE for a new hostname.
# Most symlinks point to $USERPROFILE but some point to userprofile/Documents,
# which may break when Documents is not located on the Windows C:\ drive. Rcm
# ignores broken symlinks.
hostrcrc="host-$(hostname)"
if [[ ! -d "$HOME/.dotfiles/$hostrcrc" ]]; then
  rcdn
  pushd "$HOME/.dotfiles"
  cp -r host-JOHN-AUD9AR3 "$hostrcrc"
  cp bashrc zshrc "$hostrcrc"
  cd "$hostrcrc"
  rm userprofile
  ln -s "$USERPROFILE" userprofile
  echo '*' > .gitignore
  popd
fi

env RCRC="$HOME/.dotfiles/rcrc" rcup -v # to copy/link dotfiles as specified in rcrc
env RCRC="$HOME/.dotfiles/rcrc" rcup -v # to link dotfiles symlinked to dotfiles

# Start sshd automatically using scripts developed by Pengwin.
pushd "$HOME/.dotfiles"

function cp_mod_own () {
  # $1: full path to destination, e.g. /etc/profile.d/start-ssh.sh
  # ${1:1}: relative path to source, e.g., etc/profile.d/start-ssh.sh
  # $2: permissions for $1
  sudo cp "${1:1}" "$1"
  sudo chmod "$2" "$1"
  sudo chown root.root "$1"
}

profile_d_start_ssh='/etc/profile.d/start-ssh.sh'
if [[ ! -f "${profile_d_start_ssh}" ]] ; then
  cp_mod_own "${profile_d_start_ssh}" 644
fi

bin_start_ssh='/usr/bin/start-ssh'
if [[ ! -f "${bin_start_ssh}" ]] ; then
  cp_mod_own "${bin_start_ssh}" 700
fi

sudoer_start_ssh='/etc/sudoers.d/start-ssh'
if [[ ! -f "${sudoer_start_ssh}" ]] ; then
  visudo -c -q -f "${sudoer_start_ssh:1}" && cp_mod_own "${sudoer_start_ssh}" 0440
fi

ssh_config_d="/etc/ssh/sshd_config.d/${USER}.conf"
if [[ ! -f "${ssh_config_d}" ]] ; then
  sudo sed -e "s/AllowUsers fishe/AllowUsers ${USER}/g" \
    -e "s/Port 2200/Port  ${wsl_distro_port[$WSL_DISTRO_NAME]}/g" \
    etc/ssh/sshd_config.d/fishe.conf > "${ssh_config_d}"
  sudo chmod "${ssh_config_d}" 644
  sudo chown root.root "${ssh_config_d}"
  sudo service ssh --full-restart
fi
popd

# Update font cache
# fc-cache -vf "$HOME/.local/share/fonts"

# Install zsh and oh-my-zsh
hash zsh || sudo apt install zsh
hash omz || sh -c "$(
  curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
  )"

# Miniconda https://docs.conda.io/projects/continuumio-conda/en/latest/user-guide/install/rpm-debian.html#rpm-and-debian-repositories-for-miniconda
if [[ ! -d "$HOME/miniconda3" ]] || [[ ! -f "/opt/conda/etc/profile.d/conda.sh" ]]; then
  TMP=$(mktemp -d)
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $TMP/miniconda.sh;
  bash $TMP/miniconda.sh -b
  rm -rf $TMP

  # # Install our public GPG key to trusted store
  # curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > "$TMP/conda.gpg"
  # sudo install -o root -g root -m 644 "$TMP/conda.gpg" /usr/share/keyrings/conda-archive-keyring.gpg

  # # Check whether fingerprint is correct (will output an error message otherwise)
  # gpg --keyring /usr/share/keyrings/conda-archive-keyring.gpg --no-default-keyring --fingerprint 34161F5BF5EB1D4BFBBB8F0A8AEB4F8B29D82806

  # # Add our Debian repo
  # # echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" > /etc/apt/sources.list.d/conda.list

  # # **NB:** If you receive a Permission denied error when trying to run the above command (because `/etc/apt/sources.list.d/conda.list` is write protected), try using the following command instead:
  # echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee -a /etc/apt/sources.list.d/conda.list

  # sudo apt update && sudo apt install conda

  # source /opt/conda/etc/profile.d/conda.sh
  source $HOME/miniconda3/etc/profile.d/conda.sh
  conda -V
  conda init zsh bash

  echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
  echo 'eval "$(register-python-argcomplete3 pipx)"' >> "$HOME/.zshrc"
fi

# pipx installation
hash register-python-argcomplete3 || sudo apt install python-argcomplete
hash pipx || sudo apt install pipx
pipx list || pipx reinstall-all
hash pls || pipx install pls
hash putup || pipx install 'pyscaffold[all]'
hash rich-cli || pipx install rich-cli
