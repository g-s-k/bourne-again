-- system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { silent = true })
vim.keymap.set('n', '<leader>y', '"+yy', { silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { silent = true })

-- navigation
vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', '<leader>x', ':tabclose<CR>', { silent = true })

vim.keymap.set('n', '<leader>q', function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { silent = true })

vim.keymap.set('n', '<leader>l', function()
  local loclist = vim.fn.getloclist(0, { winid = 0, size = 0 })
  if loclist.winid ~= 0 then
    vim.cmd.lclose()
  elseif loclist.size > 0 then
    vim.cmd.lopen()
  else
    vim.notify("Location list is empty.", vim.log.levels.INFO)
  end
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
