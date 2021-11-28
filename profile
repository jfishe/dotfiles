# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi
if [ -d "$USERPROFILE/bin" ] ; then
  PATH="$PATH:$USERPROFILE/bin"
fi

if [ -d "$HOME/go" ] ; then
  PATH="$PATH:$HOME/go/bin"
fi

export EDITOR=vim

# Enable ssh authentication using Windows OpenSSH ssh-agent.
if [[ ! -S /tmp/ssh-agent-pipe ]]; then
  (socat UNIX-LISTEN:/tmp/ssh-agent-pipe,fork,group=$USER,umask=007 \
      EXEC:"npiperelay.exe -ep -s //./pipe/openssh-ssh-agent",nofork &)
  export SSH_AUTH_SOCK=/tmp/ssh-agent-pipe
fi

# if [[ ! -z "$WSL_INTEROP" ]] ; then
#   # For WSL2, determine the IP address of the Hyper-V VM.
#   export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
# else
#   # Otherwise localhost should work.
#   export DISPLAY=:0
# fi

# Enable Google Chrome
export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe

# True if $1 is an executable in $PATH
# Works in both {ba,z}sh
function is_bin_in_path {
  if [[ -n $ZSH_VERSION ]]; then
    builtin whence -p "$1" &> /dev/null
  else  # bash:
    builtin type -P "$1" &> /dev/null
  fi
}
