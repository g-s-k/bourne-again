let b:ale_fixers = ['gofmt', 'remove_trailing_lines', 'trim_whitespace']

if has('nvim')
  let b:ale_linters = ['golint']

  setlocal omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <C-M> <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <C-N> <cmd>lua vim.lsp.buf.definition()<CR>
else
  let b:ale_linters = ['gopls', 'golint']
endif
