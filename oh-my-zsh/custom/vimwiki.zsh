function vimwiki () {
    if [[ $# == 0 ]]
    then
        gvim +'VimwikiMakeDiaryNote'
    elif [[ $1 == 'git' ]]
    then
        git -C ~/vimwiki/ ${@:2}
    else
        echo 'Usage: vimwiki [git] [args ...]'
    fi
}
