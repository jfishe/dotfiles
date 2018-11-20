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
            -[?cqdbxsv]|--curent|--quiet|--defaults|--both|--xterm|--schemes|--version)
                args[${#args[@]}]="$1"
                rawargs[${#args[@]}]="$1"
                shift
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
            --help|-*)
                help=
                line="    -D, --Dark     : --xterm $Dark\n"
                line="$line    -L, --Light    : --xterm $Light"
                $COLORTOOLEXE --help | awk -vline="$line" '/output/{print;print line;next}1'
                return 1
                ;;
            *)
                if [[ ! -f $1 ]]; then
                    if [[ ! -f "$path/$1" ]]; then
                        echo "Schema $1 not found."
                        return 1
                    else
                        schemaname=$(realpath -- "$path/$1")
                    fi
                else
                    schemaname=$(realpath -- "$1")
                fi

                shift
                ;;
        esac
    done

    $COLORTOOLEXE ${args[@]} "$schemaname"
}
