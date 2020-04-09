function BindNvimLspCommands()
  setlocal omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <C-[> <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <C-K> <cmd>lua vim.lsp.buf.definition()<CR>
endfunction
