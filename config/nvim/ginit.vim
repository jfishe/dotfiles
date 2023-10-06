if exists('g:GuiLoaded')
  GuiFont CaskaydiaCove\ Nerd\ Font:h11
  let g:GuiMousehide = 1
elseif exists("g:neovide")
  set guifont+=CaskaydiaCove\ Nerd\ Font
  set guifont+=CaskaydiaCove\ NF
  set guifont+=CaskaydiaCove\ Nerd\ Font\ Mono
  set guifont+=Cascadia\ Code
  set guifont+=Cascadia\ Mono
  set guifont+=DejaVu\ Sans\ Mono
  set guifont+=Consolas:h12
  let g:neovide_hide_mouse_when_typing = v:true
endif
