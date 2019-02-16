# dotfiles

Setup Windows Subsystem for Linux to use the Windows vimfiles, git and
dircolors-solarized.

## Setup Ubuntu Bash

For a new installation of Ubuntu Bash, which does not include git by default,
open Ubuntu Bash console:

```bash
sudo apt-get update         # Update package database
sudo apt-get dist-upgrade   # Upgrade to latest distribution
sudo apt-get update         # Update package database
sudo apt-get install git
sudo apt-get autoremove     # Remove unused packages
```

## Setup dotfiles

Link .bashrc, etc. to local directories. Run diff beforehand to see if WSL
has any new defaults.

[rc file (dotfile) management](https://github.com/thoughtbot/rcm)
provides rcm to manage dotfiles and installation instructions for rcm. The
man page is available at [rcm — dotfile management](http://thoughtbot.github.io/rcm/rcm.7.html).

```bash
git clone https://github.com/jfishe/dotfiles.git ~/.dotfiles
pushd ~/.dotfiles
git submodule update --init --remote
env RCRC=~/.dotfiles/rcrc lsrc # to list dotfiles that would be changed
env RCRC=~/.dotfiles/rcrc rcup # to copy/link dotfiles as specified in rcrc
```

 `env RCRC=~/.dotfiles/rcrc` is not needed after `rcup` above because it will be
linked to `~/.rcrc`.

### User Bash Completion

Put bash completion files in `~/.bash_completion.d`, which is linked to
`~/.dotfiles`. `/usr/share/bash_completion/bash_completion` sources
`~/.bash_completion` which sources all files in the `.d` directory.

### Setup gitconfig

>  TODO: <26-01-19, JD Fisher> > Fedora doesn't have wslpath; determine whether
>  Milly's version works and rewrite this section. Add section on Windows
>  environment variables that should be shared with WSL. Add instructions for
>  creating/updating ~/.dotfiles/host-xxx, since the links are `%USERPROFILE%`
>  dependent.

Path needs to reflect %USERPROFILE%, so we'll use an environment variable and
wslpath to figure it out, assuming System32 is in `PATH` per `.bashrc`.

```bash
DIRECTORY=~/Git
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
fi
git clone  https://github.com/Milly/wslpath.git ~/Git/wslpath
```

If `.local/bin` is not in `$PATH`:

```bash
export PATH=~/.local/bin:$PATH
```

```bash
DIRECTORY=~/.local/bin
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
fi

ln -s ~/Git/wslpath/wslpath ~/.local/bin/wslpath
USERPROFILE=$(wslpath `cmd.exe /c echo %USERPROFILE%`)

ln -s $USERPROFILE/.gitconfig ~/.gitconfig
ln -s $USERPROFILE/.gitmessage.txt ~/.gitmessage.txt
ln -s $USERPROFILE/.gitattributes_global ~/.gitattributes_global
```

To eliminate entering user and password with every push, create
`~/Git/dotfiles/gitconfig` with path to `git-credential-wincred.exe`, for
example:

```{contenteditable="true" spellcheck="false" caption="git" .git}
[credential]
helper = /mnt/c/Program\\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe
```

## Color Scheme

.bashrc uses ~/.dircolors if it exists.
[`dircolors-solarized`](https://github.com/seebi/dircolors-solarized.git) is
included as a `git submodule` in `~/.dotfiles/.dircolors-solarized/`, which
`~/.dircolors` links to.

## Anaconda3 and Vim

Install Anaconda3 before starting Vim. WSL Ubuntu defaults python to v2.7
instead of python3. Vim-conda uses python -c which will fail if python3 is
aliased to in vim-conda. The vimrc and gvimrc assumed to be in vimfiles.

>  TODO:  <26-01-19, JD Fisher> > Sharing the backup directory with Windows vim
>  may be causing Gutentags to fail. Needs triage.

Ctags is needed by Gutentags. Wslpath converts Windows paths to their mount
point under WSL.

Vim 8 and Silver Searcher are not required but Ag is much faster. VWS will use
Ag if installed. `TeXLive` is needed for pandoc.

```bash
# Add repo for Vim 8 and texlive-2018
sudo add-apt-repository ppa:jonathonf/vim
sudo add-apt-repository ppa:jonathonf/texlive-2018
sudo apt-get update

sudo apt-get install silversearcher-ag
sudo apt install vim
sudo apt install exuberant-ctags
sudo apt-get install texlive-full # will take a long time
sudo apt-get golang

>  TODO:  <26-01-19, JD Fisher> > Refactor. Links are created in
>  `~/.dotfiles/host-xxx`. Unfortunately it's host and user specific since rcm
>  doesn't appear to be able to create links after `~/userprofile` is linked.
>  The links would be host independent then. Create a shell script?

USERPROFILE=$(wslpath `cmd.exe /c echo %USERPROFILE%`)
ln -s $USERPROFILE/vimfiles/ ~/.vim
ln -s $USERPROFILE/.jupyter/ ~/.jupyter
ln -s $USERPROFILE/ ~/userprofile

go get -u mvdan.cc/sh/cmd/shfmt # https://github.com/mvdan/sh
```

If the `Documents` folder is not located in `$USERPROFILE/Documents`, the
actual location can be obtained from the Windows Registry.

<!-- markdownlint-disable MD013 -->

```powershell
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
(Get-ItemProperty -Path $registryPath -Name "Personal").Personal
```

<!-- markdownlint-enable MD013 -->

If a network share is involved,
[Microsoft][file system improvements to the windows subsystem for linux]
provides guidance for mounting the URI. Limitations in WSL may prevent
auto-mounting network shares. After mounting the network share the first
time, copy the `/proc/mounts` entry into `/etc/fstab`. E.g.,

```bash
sudo mkdir -p /mnt/u

sudo mount -t drvfs U: /mnt/u
cat /proc/mounts

# Update based on preceding info.
sudo echo 'U: /mnt/u drvfs rw,relatime 0 0' >> /etc/fstab
```

If automount doesn't succeed after logout/login, `sudo mount /mnt/u` will
restore the mount point. Adjust the following path to reflect the mount point
for the `Documents` folder.

```bash
ln -s $USERPROFILE/Documents/vimwiki ~/vimwiki
```

[file system improvements to the windows subsystem for linux]: https://blogs.msdn.microsoft.com/wsl/2017/04/18/file-system-improvements-to-the-windows-subsystem-for-linux/

## Running Windows gvim.exe from WSL

Within the Windows file system (e.g., `/mnt/c`), the Windows version of gvim
can be launched. The `gvim` function will exit quietly if on a WSL path.
[lifthrasiir/gvim.sh](https://gist.github.com/lifthrasiir/29c34b879aad9d2e7f564e10c45c1e61)
provides a gist, which has been modified for `Vim81`. Adjust the path to `gvim`
as needed. See `~/.dotfiles/local/bin/gvim.sh` for details.


```bash
source ~/.dotfiles/local/bin/gvim.sh
```

## Running gvim with X11

To install gvim with clipboard support, run an X11 server, e.g., X410 and
install `vim-gtk3`. If the clipboard does not appear to be sharing, copy from
and X client and paste into a Windows application. Then it should work both
ways.

``` {contenteditable="true" spellcheck="false" caption="bash" .bash}
sudo apt-get install vim-gtk3
```

