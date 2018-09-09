gvim() {
	local args rawargs path base usegvim=1 noopt=
	declare -a args
	rawargs=("$@")
	while (($#)); do
		case "$noopt$1" in
		-[cSdirsTuUwW]|--cmd|--remote-expr|--remote-send|--servername|--version)
			args[${#args[@]}]="$1"
			rawargs[${#args[@]}]="$1"
			shift
			if (($#)); then
				args[${#args[@]}]="$1"
				shift
			fi
			;;
		--)
			noopt=x
			args[${#args[@]}]="$1"
			shift
			;;
		-*)
			args[${#args[@]}]="$1"
			shift
			;;
		*)
			path=$(realpath -- "$1")
			if [[ "$path" =~ ^/mnt/[a-z]/ ]]; then
				base=${path:7}
				args[${#args[@]}]="${path:5:1}:\\${base/\//\\}"
			else
				# fall back to the linux native version
				usegvim=0
				break
			fi
			shift
			;;
		esac
	done
	if (($usegvim)); then
		"/mnt/c/Program Files/Vim/vim81/gvim.exe" "${args[@]}"
	else
		vim "${rawargs[@]}"
	fi
}
