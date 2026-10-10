vim.diagnostic.config({
  virtual_lines = true,
})

vim.keymap.set('n', '<leader>v', function()
  local cfg = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = cfg })
end, {
  silent = true,
  desc = 'Toggle diagnostic virtual_lines setting',
})

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { silent = true })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { silent = true })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setqflist, { silent = true })

local format_group = vim.api.nvim_create_augroup('lsp-format-on-save', {})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local buf = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buf, silent = true })
    end
    if client:supports_method('textDocument/formatting') then
      vim.keymap.set({ 'n', 'v' }, '<leader>F', vim.lsp.buf.format, { buffer = buf, silent = true })

      -- Clear first so that each buffer has at most one format-on-save autocmd.
      vim.api.nvim_clear_autocmds({ group = format_group, buffer = buf })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = format_group,
        buffer = buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = buf, timeout_ms = 500 })
        end,
      })
    end
  end,
})

vim.lsp.enable({ 'clangd', 'rust-analyzer', 'lua-ls', 'zls' })
