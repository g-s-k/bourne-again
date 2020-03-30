let b:ale_fixers = ['rustfmt', 'remove_trailing_lines', 'trim_whitespace']

if has('nvim') && exists('g:nvim_lsp')
  let b:ale_linters = ['cargo']

  packadd nvim-lsp
  lua require'nvim_lsp'.rust_analyzer.setup{ cmd = { 'ra_lsp_server' } }

  setlocal omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <C-M> <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <C-N> <cmd>lua vim.lsp.buf.definition()<CR>
else
  let b:ale_linters = ['cargo', 'rls']

  if executable('ra_lsp_server')
    let b:ale_rust_rls_executable = 'ra_lsp_server'
  endif
endif
