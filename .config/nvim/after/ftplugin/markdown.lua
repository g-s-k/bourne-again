vim.cmd.runtime('after/ftplugin/text.lua')

vim.opt_local.conceallevel = 2
vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
