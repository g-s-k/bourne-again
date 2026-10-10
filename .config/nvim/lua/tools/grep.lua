vim.opt.grepprg = 'rg --vimgrep'

vim.keymap.set('n', '<leader>*', function()
  vim.cmd.grep('--word-regexp --fixed-strings ' .. vim.fn.expand('<cword>'))
  vim.cmd.copen()
end, { silent = true })
