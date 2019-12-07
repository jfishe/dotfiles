#!/usr/bin/env bash
# Bash & Zsh compatible

# Toggle ColorTool.exe colorschemes.
# Default to dark.
# ColorTool.exe should be in PATH
function yob() {
    local dark light colortoolexe

    dark='solarized.dark.itermcolors'
    light='solarized.light.itermcolors'
    colortoolexe="ColorTool.exe"

    if command -v "$colortoolexe" > /dev/null 2>&1; then
        if [[ "$COLORSCHEME " == "$dark " ]]; then
           COLORSCHEME="$light"
        else
           COLORSCHEME="$dark"
        fi
        export COLORSCHEME
        $colortoolexe --xterm --quiet "$COLORSCHEME"
    fi
}
