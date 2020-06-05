-- see https://github.com/neovim/nvim-lsp/issues/69#issuecomment-616816555
do
  local method = "textDocument/publishDiagnostics"
  local default_callback = vim.lsp.callbacks[method]
  vim.lsp.callbacks[method] = function(err, method, result, client_id)
    default_callback(err, method, result, client_id)
    if result and result.diagnostics then
      for _, v in ipairs(result.diagnostics) do
        v.bufnr = client_id
        v.lnum = v.range.start.line + 1
        v.col = v.range.start.character + 1
        v.text = v.message
      end
      vim.lsp.util.set_loclist(result.diagnostics)
    end
  end
end


local lsp = require'nvim_lsp'

lsp.bashls.setup{}
lsp.cssls.setup{}
lsp.dockerls.setup{}
lsp.gopls.setup{}
lsp.html.setup{}
lsp.jsonls.setup{}
lsp.rust_analyzer.setup{}
lsp.tsserver.setup{}
lsp.vimls.setup{}
