if has('nvim') && exists('g:nvim_lsp')
  packadd nvim-lsp
  lua require'nvim_lsp'.jsonls.setup{}
endif
