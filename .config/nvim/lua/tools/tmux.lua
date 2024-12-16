local try_navigate_panes = function(direction)
  local window_before = vim.fn.winnr()
  vim.cmd.wincmd(direction)
  if vim.env.TMUX and window_before == vim.fn.winnr() then
    local d = {
      h = 'L',
      j = 'D',
      k = 'U',
      l = 'R',
    }
    vim.fn.system {
      'tmux',
      'select-pane',
      '-t', vim.env.TMUX_PANE,
      '-' .. d[direction]
    }
  end
end

vim.keymap.set('n', '<C-h>', function() try_navigate_panes('h') end, { silent = true })
vim.keymap.set('n', '<C-j>', function() try_navigate_panes('j') end, { silent = true })
vim.keymap.set('n', '<C-k>', function() try_navigate_panes('k') end, { silent = true })
vim.keymap.set('n', '<C-l>', function() try_navigate_panes('l') end, { silent = true })
