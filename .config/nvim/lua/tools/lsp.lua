vim.diagnostic.config({
  virtual_lines = true,
})

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { silent = true })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { silent = true })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setqflist, { silent = true })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
    end
    if client.supports_method('textDocument/formatting') then
      vim.keymap.set({ 'n', 'v' }, '<leader>F', vim.lsp.buf.format, { silent = true })

      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function(args)
          vim.lsp.buf.format({ timeout_ms = 500 })
        end,
      })
    end
  end,
})

vim.lsp.enable({ 'clangd', 'rust-analyzer', 'lua-ls', 'zls' })
