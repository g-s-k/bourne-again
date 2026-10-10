vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

vim.keymap.set({ 'n', 'x' }, 'j', 'gj', { buffer = true })
vim.keymap.set({ 'n', 'x' }, 'k', 'gk', { buffer = true })

vim.opt_local.spell = true
vim.opt_local.spelllang = { 'en', 'sv' }
