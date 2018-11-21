colortool() {
    local args rawargs COLORTOOLEXE path base schemaname= rc Dark Light help line

    declare -a args
    rawargs=("$@")

    path="$HOME/userprofile/Documents/WindowsPowerShell"
    COLORTOOLEXE="$path/ColorTool.exe"
    Dark=$(wslpath -m "$(realpath -- "$path/Solarized Dark Higher Contrast.itermcolors")")
    Light=$(wslpath -m "$(realpath -- "$path/solarized_light.itermcolors")")

    while (($#)); do
        case "$noopt$1" in
            -[?cqdbxv]|--curent|--quiet|--defaults|--both|--xterm|--version)
                args[${#args[@]}]="$1"
                rawargs[${#args[@]}]="$1"
                shift
                ;;
            -D|--Dark)
                args[${#args[@]}]="--xterm"
                schemaname="$Dark"
                rawargs[${#args[@]}]="$1"
                shift
                ;;
            -L|--Light)
                args[${#args[@]}]="--xterm"
                schemaname="$Light"
                rawargs[${#args[@]}]="$1"
                shift
                ;;
            -s|--schemes)
                echo 'Schemes found in:'
                pushd $path | cut -d ' ' -f 1
                $COLORTOOLEXE --schemes
                rc=$?
                # popd > /dev/null
                return $rc
                ;;
            -o|--output)
                args[${#args[@]}]="$1"
                rawargs[${#args[@]}]="$1"
                shift
                if (($#)); then
                    args[${#args[@]}]="$(wslpath -w $(realpath -- "$1"))"
                    shift
                fi
                ;;
            --help|-*)
                help=
                line="    -D, --Dark     : --xterm $Dark\n"
                line="$line    -L, --Light    : --xterm $Light"
                $COLORTOOLEXE --help | awk -vline="$line" '/output/{print;print line;next}1'
                return 1
                ;;
            *)
                # ColorTool looks in current and schemes sub-directory for
                # schemes.
                if [[ ! -f $1 ]]; then
                    if [[ -f "$path/$1" || -f "$path/schemes/$1" ]]; then
                        schemaname="$1"
                    else
                        echo "Schema $1 not found."
                        return 1
                    fi
                else
                    # Fail gracefully if can't reach file location from
                    # Windows.
                    schemaname="$(wslpath -w $(realpath -- "$1"))"
                fi

                shift
                ;;
        esac
    done

    # ColorTool looks in current and schemes sub-directory for schemes.
    pushd $path > /dev/null
    $COLORTOOLEXE ${args[@]} "$schemaname"
    rc=$?
    popd > /dev/null
    return $?
}
