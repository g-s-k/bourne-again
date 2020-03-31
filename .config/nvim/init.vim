source ~/.vim/vimrc

packadd nvim-lsp

lua <<EOF
  local lsp = require'nvim_lsp'

  lsp.dockerls.setup{}
  lsp.gopls.setup{}
  lsp.html.setup{}
  lsp.jsonls.setup{}
  lsp.rust_analyzer.setup{}
  lsp.tsserver.setup{}
  lsp.vimls.setup{}
EOF
