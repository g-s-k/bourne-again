source ~/.vimrc

packadd nvim-lspconfig

au VimEnter * highlight SpellBad ctermbg=1

lua <<EOF
  local lsp = require'nvim_lsp'

  lsp.bashls.setup{}
  lsp.cssls.setup{}
  lsp.dockerls.setup{}
  lsp.elixirls.setup{ cmd = { "/home/gskaplan/.cache/nvim/nvim_lsp/elixirls/elixir-ls/apps/elixir_ls_utils/priv/language_server.sh" } }
  lsp.gopls.setup{}
  lsp.html.setup{}
  lsp.jsonls.setup{}
  lsp.rust_analyzer.setup{}
  lsp.tsserver.setup{}
  lsp.vimls.setup{}
EOF
