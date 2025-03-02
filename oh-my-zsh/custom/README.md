# Oh My Zsh Custom

## Custom Aliases

`aliases.zsh`

### Custom Astral uv Completion

- [Install uv]
- Update zsh completion.

```bash
uv generate-shell-completion zsh > "$ZSH_CUSTOM/uv.zsh"
```

### Custom Vimwiki-Cli Completion

[Vimwiki Command-Line Interface] provides Shell Completion via [Click].

```bash
_VIMWIKI_COMPLETE=zsh_source vimwiki > "$ZSH_CUSTOM/vimwiki.zsh"
```

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

[Install uv]: https://docs.astral.sh/uv/getting-started/installation/
[Vimwiki Command-Line Interface]: https://github.com/sstallion/vimwiki-cli
[Click]: https://click.palletsprojects.com/en/stable/shell-completion/
[conda-zsh-completion]: https://github.com/esc/conda-zsh-completion
[zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting
[zsh-dircolors-solarized]: https://github.com/joel-porquet/zsh-dircolors-solarized
