let b:ale_fixers = ['prettier-eslint', 'eslint', 'remove_trailing_lines', 'trim_whitespace']

if has('nvim') && exists('g:nvim_lsp')
  let b:ale_linters = ['eslint']

  packadd nvim-lsp
  lua require'nvim_lsp'.tsserver.setup{}

  setlocal omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <C-M> <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <C-N> <cmd>lua vim.lsp.buf.definition()<CR>
endif
