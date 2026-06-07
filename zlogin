if [[ -f "$HOME/.profile" ]]; then
    . $HOME/.profile
  [[ -n "$ZSH_VERSION" ]] && [[ -n "$WT_SESSION" ]] && precmd_functions+=(__wt_osc9_9)
fi
