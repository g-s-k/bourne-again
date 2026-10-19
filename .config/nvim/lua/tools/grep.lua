vim.opt.grepprg = 'rg --vimgrep'

vim.keymap.set('n', '<leader>*', function()
  vim.cmd.grep({
    args = { '--word-regexp', '--fixed-strings', vim.fn.expand('<cword>') },
    bang = true,
    mods = { silent = true }
  })
end, { silent = true })

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = '[^l]*',
  command = 'cwindow'
})
