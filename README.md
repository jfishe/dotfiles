# dotfiles

Setup Windows Subsystem for Linux to use the Windows vimfiles, git and
dircolors-solarized. Complete the Windows setup first per instructions at
[jfishe / vimfiles](https://github.com/jfishe/vimfiles)
instructions.

To install download and source the following or perform the steps described
below.

In Windows, set the user environment variable `WSLENV`, for use by
`install.sh`.

```bash
WSLENV='WT_SESSION:USERPROFILE/p:APPDATA/p:LOCALAPPDATA/p:TMP/p:WT_PROFILE_ID'
```

See [Share environment variables between Windows and WSL](https://docs.microsoft.com/en-us/windows/wsl/interop#share-environment-variables-between-windows-and-wsl)
for additional information.

Download and source `install.sh`.

```bash
. ./install.sh
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
git submodule update --init --recursive --remote
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

> TODO: <26-01-19, JD Fisher> > Fedora doesn't have wslpath; determine whether
> Milly's version works and rewrite this section. Add section on Windows
> environment variables that should be shared with WSL. Add instructions for
> creating/updating ~/.dotfiles/host-xxx, since the links are `%USERPROFILE%`
> dependent.

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

## Miniconda and Vim

Install Miniconda before starting Vim. [Conda](https://docs.conda.io/projects/continuumio-conda/)
provides [RPM and Debian Repositories for Miniconda](https://docs.conda.io/projects/continuumio-conda/en/latest/user-guide/install/rpm-debian.html#rpm-and-debian-repositories-for-miniconda)

Universal-ctags is needed by Gutentags. Wslpath converts Windows paths to their
mount point under WSL.

Vim 8 and ripgrep are not required, but rg is much faster. VimwikiSearch will
use Rg if installed. `TeXLive` is needed for pandoc.

```bash
sudo apt-get install ripgrep
sudo apt install vim-gtk3
sudo apt install universal-ctags
sudo apt-get install texlive-full # will take a long time
sudo apt-get golang

USERPROFILE=$(wslpath `cmd.exe /c echo %USERPROFILE%`)
ln -s $USERPROFILE/vimfiles/ ~/.vim
ln -s $USERPROFILE/.jupyter/ ~/.jupyter
ln -s $USERPROFILE/ ~/userprofile

# https://github.com/mvdan/sh
GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
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

```{contenteditable="true" spellcheck="false" caption="bash" .bash}
sudo apt-get install vim-gtk3
```

## SSH Configuration

[SSH on WSL](https://www.illuminiastudios.com/dev-diaries/ssh-on-windows-subsystem-for-linux/)

## Fonts for Gvim

### Nerd Fonts

[Nerd Fonts](https://github.com/buzzkillhardball/nerdfonts) is a project that
attempts to patch as many developer targeted fonts as possible with a high
number of additional glyphs (icons). The main goal is to specifically add
a high number of additional glyphs from popular 'iconic fonts' such as Font
Awesome, Devicons, Octicons, and others.

### Cascadia-Code Fonts

[Microsoft Cascadia Code Powerline font](https://github.com/microsoft/cascadia-code/releases)
works well in WSL and Windows.

### Caskaydia Cove Regular Nerd Font

[Caskaydia Cove](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode/Regular)
patches Cascadia-Code with powerline and nerd font glyphs. It
is the default for gVim in [https://github.com/jfishe/vimfiles](https://github.com/jfishe/vimfiles).

### Font Installation

Download selected fonts to the directory below and update the font cache. WSL
should use Windows Compatible fonts.

```{contenteditable="true" spellcheck="false" caption="bash" .bash}
fc-cache -vf ~/.local/share/fonts
```

Otherwise, install the fonts in Windows and share with WSL.
Copy [`etc/fonts/local.conf`](etc/fonts/local.conf) to `/etc/fonts/local.conf`.
[Sharing Windows fonts with WSL](https://x410.dev/cookbook/wsl/sharing-windows-fonts-with-wsl/)
provides details. You may need to install
[`wslu`](https://wslutiliti.es/wslu/install.html) for `wslview`.


```{contenteditable="true" spellcheck="false" caption="bash" .bash}
# To install wslu on Ubuntu 22.04 or later
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu

# To download only the CaskaydiaCove fonts, shallow clone Nerd Fonts.
git clone -n --depth=1 --filter=tree:0 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
git sparse-checkout set --no-cone patched-fonts/CascadiaCode/Regular
git checkout

# Install in Windows
cd patched-fonts/CascadiaCode/Regular
wslview .
# Virus scan, select ttf files and right-click install.

# Update the font cache
fc-cache -v
```

## Taskwarrior

Vimwiki and taskwiki are configured to use the TASKRC and TASKDATA located in
the Vimwiki root. Either set the environment or link to the appropriate
locations to use `task` from the shell.
