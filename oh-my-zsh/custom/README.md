# Oh My Zsh Custom

## Custom Aliases

`aliases.zsh`

### Custom Astral uv Completion

- [Install uv](https://docs.astral.sh/uv/getting-started/installation/)
- Update zsh completion.

```bash
uv generate-shell-completion zsh > "$ZSH_CUSTOM/uv.zsh"
```
## Custom Plugins

### Anaconda Conda Completion

- [conda-zsh-completion](https://github.com/esc/conda-zsh-completion)
  does not describe installing as an Oh-My-Zsh custom plugin.
  The following was done and added to `rcrc`, but might be useful in a new dot
  files repository.
- Add `conda-zsh-completion` to `plugins=()` in `.zshrc`.

```bash
git submodule add https://github.com/esc/conda-zsh-completion \
  "$ZSH_CUSTOM/plugins/conda-zsh-completion"
```

### Fish Style Syntax Highlighting

[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### DirColors Solarized

[zsh-dircolors-solarized](https://github.com/joel-porquet/zsh-dircolors-solarized)
