source ~/.vimrc

packadd nvim-lsp

au VimEnter * highlight Pmenu ctermfg=7 ctermbg=0
au VimEnter * highlight SpellBad ctermbg=1

lua <<EOF
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
EOF
