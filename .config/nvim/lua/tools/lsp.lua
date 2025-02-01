vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { silent = true })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { silent = true })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setqflist, { silent = true })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method('textDocument/codeAction') then
      vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, { silent = true })
    end
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
    if client.supports_method('textDocument/implementation*') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
    end
    if client.supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true })
    end
    if client.supports_method('textDocument/rename') then
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { silent = true })
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function(ev)
    vim.lsp.start({
      name = 'clangd',
      cmd = { 'clangd', '--clang-tidy' },
      root_dir = vim.fs.root(ev.buf, { 'CMakeLists.txt', 'Makefile', 'README.md' }),
    })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function(ev)
    vim.lsp.start({
      name = 'rust-analyzer',
      cmd = { 'rust-analyzer' },
      root_dir = vim.fs.root(ev.buf, { 'Cargo.lock' }),
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = 'clippy',
          },
          diagnostics = {
            disabled = { 'inactive-code' },
          },
        },
      },
    })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'zig',
  callback = function(ev)
    vim.lsp.start({
      name = 'zls',
      cmd = { 'zls' },
      root_dir = vim.fs.root(ev.buf, { 'build.zig' }),
    })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function(ev)
    vim.lsp.start({
      name = 'lua-ls',
      cmd = { 'lua-language-server' },
    })
  end
})
