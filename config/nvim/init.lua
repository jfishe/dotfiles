if vim.g.vscode == nil then
  vim.opt.runtimepath:prepend('~/.vim')
  vim.opt.runtimepath:append('~/.vim/after')
  vim.opt.packpath = vim.opt.runtimepath:get()
  vim.opt.guicursor = {
    'n-v-c:block',
    'i-ci-ve:ver25',
    'r-cr:hor20',
    'o:hor50',
    'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
    'sm:block-blinkwait175-blinkoff150-blinkon175'
  }

  vim.g.polyglot_disabled = { 'markdown', 'ps1' }

  local myguicursor = vim.api.nvim_create_augroup(
    'myguicursor',
    { clear = true }
    )
  vim.api.nvim_create_autocmd(
    {'VimLeave'}, {
      pattern = {'*'},
      group = myguicursor,
      command = 'set guicursor= | call chansend(v:stderr, "\x1b[0 q")',
    })

  vim.g.python3_host_prog = vim.fn.expand(
    '~/miniforge3/envs/vim-python/bin/python'
    )
  vim.cmd('source ~/.vim/vimrc')
end
