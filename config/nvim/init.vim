if !exists('g:vscode')
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  let g:polyglot_disabled = [ 'markdown', 'ps1' ]
  " colorscheme solarized8

  let g:python3_host_prog = expand("~/miniconda3/envs/vim-python/bin/python")

  source ~/.vim/vimrc
endif
