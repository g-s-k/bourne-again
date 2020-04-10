function BindNvimLspCommands()
  setlocal omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <Leader>r <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <Leader>f <cmd>lua vim.lsp.buf.references()<CR> :copen<CR>
  nnoremap <Leader>d <cmd>lua vim.lsp.buf.definition()<CR>
endfunction
