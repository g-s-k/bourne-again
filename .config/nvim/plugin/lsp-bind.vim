function BindNvimLspCommands()
  setlocal omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <Leader>r <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <Leader>f <cmd>lua vim.lsp.buf.references()<CR> :copen<CR>
  nnoremap <Leader>d <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <Leader>s <cmd>lua vim.lsp.buf.document_symbol()<CR> :copen<CR>
  nnoremap <Leader>h <cmd>lua vim.lsp.buf.hover()<CR>

  nnoremap <silent> ]r :lua require'lsp'.next_diagnostic()<CR>
  nnoremap <silent> [r :lua require'lsp'.previous_diagnostic()<CR>

  autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()
  autocmd CursorMoved <buffer> lua vim.lsp.util.show_line_diagnostics()
endfunction
