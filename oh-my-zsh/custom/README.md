# Oh My Zsh Custom

## Custom Aliases

[`$ZSH_CUSTOM/aliases.zsh`](aliases.zsh)

## Custom Completions Autoloaded Files

[A Users' Guide to the Z-Shell](https://zsh.sourceforge.io/Guide/zshguide06.html#l183 "6.9.1: Loading completion functions: compdef")
explains completion functions in
[`$ZSH_CUSTOM/completions`](completions/)

1. Remove `$HOME/.zcompdump*`, so `compinit` updates completions.

2. Add completion scripts or script generators to
   `$ZSH_CUSTOM/completions/`.

3. Name the files after the command,
   preceded by an underscore.

4. If not already present, add `#compdef command` to the top of the file.

   E.g., for [Vimwiki Command-Line Interface],
   `$ZSH_CUSTOM/completions/_vimwiki` contains the following:

   ```bash
   #compdef vimwiki

   eval "$(_VIMWIKI_COMPLETE=zsh_source vimwiki)"
   ```

5. `compinit` rebuilds completions at the next login.

## Custom Plugins

### Conda Completion

- [conda-zsh-completion] does not describe installing as an Oh-My-Zsh custom
  plugin. The following was done and added to `rcrc`, but might be useful in a
  new dot files repository.
- Add `conda-zsh-completion` to `plugins=()` in `.zshrc`.

```bash
git submodule add https://github.com/esc/conda-zsh-completion \
  "$ZSH_CUSTOM/plugins/conda-zsh-completion"
```

### Fish Style Syntax Highlighting

[zsh-syntax-highlighting]

### DirColors Solarized

[zsh-dircolors-solarized]

[conda-zsh-completion]: https://github.com/esc/conda-zsh-completion
[vimwiki command-line interface]: https://github.com/sstallion/vimwiki-cli
[zsh-dircolors-solarized]: https://github.com/joel-porquet/zsh-dircolors-solarized
[zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting
