# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/.local/bin:$PATH"
PATH="$PATH:/home/fishe/go/bin"

export EDITOR=vim

# Enable git authentication using Windows
export SSH_AUTH_SOCK="/tmp/.ssh-auth-sock"
~/.local/bin/msysgit2unix-socket.py $HOME/userprofile/keeagent_msysGit.socket:$SSH_AUTH_SOCK
# > /dev/null 2>&

# Enable Google Chrome
export DISPLAY=:0
export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe

# rcm dotfile management
export RCRC="$HOME/.dotfiles/.rcrc"

conda activate base
