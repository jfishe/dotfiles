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
            -[?cqdbxsv]|--curent|--quiet|--defaults|--both|--xterm|--schemes|--version|--output)
                args[${#args[@]}]="$1"
                rawargs[${#args[@]}]="$1"
                shift
                ;;
            -o|--output)
                args[${#args[@]}]="$1"
                rawargs[${#args[@]}]="$1"
                shift
                if (($#)); then
                    args[${#args[@]}]="$1"
                    shift
                fi
                ;;
            -Dark)
                args[${#args[@]}]="--xterm $Dark"
                rawargs[${#args[@]}]="$1"
                shift
                ;;
            -Light)
                args[${#args[@]}]="--xterm $Light"
                rawargs[${#args[@]}]="$1"
                shift
                ;;
            --help|-*)
                help=
                line="    -Dark          : --xterm $Dark\n"
                line="$line    -Light         : --xterm $Light"
                $COLORTOOLEXE --help | awk -vline="$line" '/output/{print;print line;next}1'
                rc=1
                break
                ;;
            *)
                if [[ ! -f $1 ]]; then
                    if [[ ! -f "$path/$1" ]]; then
                        echo "Schema $1 not found."
                        rc=1
                        break
                    else
                        schemaname=$(realpath -- "$path/$1")
                    fi
                else
                    schemaname=$(realpath -- "$1")
                fi

                args[${#args[@]}]="$(wslpath -m $schemaname)"
                shift
                ;;
        esac
    done

    # echo "${args[@]} $schemaname"
    if (( $rc )); then
        echo "EXIT" 1
    else
        $COLORTOOLEXE "${args[@]}"
    fi
}
