source ~/.vimrc

packadd nvim-lsp

au VimEnter * highlight Pmenu ctermfg=7 ctermbg=0
au VimEnter * highlight SpellBad ctermbg=1

lua require'lsp'
