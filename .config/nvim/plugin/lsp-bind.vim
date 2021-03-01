function BindNvimLspCommands()
  setlocal omnifunc=v:lua.vim.lsp.omnifunc
  setlocal keywordprg=":lua vim.lsp.buf.incoming_calls()"

  nnoremap <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <Leader>r <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <Leader>f <cmd>lua vim.lsp.buf.references()<CR> :copen<CR>
  nnoremap <Leader>s <cmd>lua vim.lsp.buf.document_symbol()<CR> :copen<CR>
  nnoremap <Leader>c <cmd>lua vim.lsp.buf.incoming_calls()<CR>

  nnoremap <silent> [r <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
  nnoremap <silent> ]r <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

  autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()

  " Enable type inlay hints
  autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer>
  \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
endfunction
