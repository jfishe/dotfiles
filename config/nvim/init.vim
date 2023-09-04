if !exists('g:vscode')
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  let g:polyglot_disabled = [ 'markdown', 'ps1' ]
  " colorscheme solarized8

  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
        \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
        \,sm:block-blinkwait175-blinkoff150-blinkon175
  augroup myguicursor
    autocmd!
    autocmd VimLeave * set guicursor= | call chansend(v:stderr, "\x1b[0 q")
  augroup END

  let g:python3_host_prog = expand("~/miniconda3/envs/vim-python/bin/python")

  source ~/.vim/vimrc
endif
