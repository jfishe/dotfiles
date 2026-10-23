if [[ -f "$HOME/.profile" ]]; then
    . $HOME/.profile
fi

# Windows Terminal shell integration (FTCS marks), see
# https://learn.microsoft.com/en-us/windows/terminal/tutorials/shell-integration
if [[ -n "$ZSH_VERSION" && -n "$WT_SESSION" ]] && (( $+functions[__wt_osc9_9] )); then
  __wt_precmd() {
    local ret=$?
    # Skip D before the first prompt (no command has run yet)
    (( ${+__wt_started} )) && printf '\e]133;D;%s\e\\' "$ret"
    typeset -g __wt_started=1
    __wt_osc9_9
  }
  __wt_preexec() { printf '\e]133;C\e\\' }
  # First in the list, so $? is still the user's command status
  precmd_functions=(__wt_precmd ${precmd_functions:#__wt_precmd})
  preexec_functions+=(__wt_preexec)
  PROMPT=$'%{\e]133;A\e\\%}'"$PROMPT"$'%{\e]133;B\e\\%}'
fi
