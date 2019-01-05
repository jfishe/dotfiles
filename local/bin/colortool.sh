#!/usr/bin/env bash

# Toggle ColorTool.exe colorschemes.
# Default to COLORSCHEME[0].
# Declare COLORSCHEME externally and it will use your version.
# ColorTool.exe should be in PATH and all schemes in schemes/ in the same
# directory as ColorTool.exe.
function yob() {
    local colortoolexe

    if [ -z ${COLORSCHEME+x} ]; then
        declare -ag COLORSCHEME=('solarized.dark' 'solarized.light')
    fi
    colortoolexe="ColorTool.exe"

    if command -v "$colortoolexe" > /dev/null 2>&1; then
        current_colorscheme=$((current_colorscheme==0))
        $colortoolexe --xterm --quiet "${COLORSCHEME[${current_colorscheme}]}"
    fi
}
