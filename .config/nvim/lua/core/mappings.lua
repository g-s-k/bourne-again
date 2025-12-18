-- system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { silent = true })
vim.keymap.set('n', '<leader>y', '"+yy', { silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { silent = true })

-- navigation
vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', '<leader>x', ':tabclose<CR>', { silent = true })

vim.keymap.set('n', '<leader>q', function()
  local tabnr = vim.fn.tabpagenr()
  local window = vim.tbl_filter(function(t)
    return t.tabnr == tabnr and t.quickfix == 1 and t.loclist == 0
  end, vim.fn.getwininfo())[1]
  if window then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { silent = true })

vim.keymap.set('n', '<leader>l', function()
  -- TODO
  vim.cmd.lclose()
end, { silent = true })

-- surround (basic)
vim.keymap.set('v', 's(', 'c(<C-r>")<ESC>', { silent = true })
vim.keymap.set('v', 's)', 'c( <C-r>" )<ESC>', { silent = true })
vim.keymap.set('v', 's[', 'c[<C-r>"]<ESC>', { silent = true })
vim.keymap.set('v', 's]', 'c[ <C-r>" ]<ESC>', { silent = true })
vim.keymap.set('v', 's{', 'c{<C-r>"}<ESC>', { silent = true })
vim.keymap.set('v', 's}', 'c{ <C-r>" }<ESC>', { silent = true })
vim.keymap.set('v', 's<', 'c<<C-r>"><ESC>', { silent = true })
vim.keymap.set('v', 's>', 'c< <C-r>" ><ESC>', { silent = true })

vim.keymap.set('v', 's"', 'c"<C-r>""<ESC>', { silent = true })
vim.keymap.set('v', 's\'', 'c\'<C-r>"\'<ESC>', { silent = true })
vim.keymap.set('v', 's`', 'c`<C-r>"`<ESC>', { silent = true })
