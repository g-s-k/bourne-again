local float = require('util.float')

local is_repo = function()
  if vim.fs.root(0, { '.git' }) then
    return true
  end

  vim.notify("Not in a git repository.", vim.log.levels.WARN)
  return false
end

local any_diff = function(opts)
  opts = opts or {}

  local cmd = { 'git', 'diff', '--quiet' }

  if opts.staged then
    table.insert(cmd, '--cached')
  end

  if vim.system(cmd):wait().code == 0 then
    vim.notify("No changes.", vim.log.levels.INFO)
    return false
  end

  return true
end

vim.api.nvim_create_user_command('GStatus', function()
  if not is_repo() then
    return
  end

  float.run_shell {
    cmd = 'git status -vv',
    use_pager = true,
  }
end, {})

vim.api.nvim_create_user_command('GAdd', function()
  if not (is_repo() and any_diff()) then
    return
  end

  float.open { cmd = { 'git', 'add', '--patch' } }
end, {})


local restore = function(opts)
  opts = opts or {}

  if not (is_repo() and any_diff({ staged = opts.staged })) then
    return
  end

  local cmd = { 'git', 'restore', '--patch' }

  if opts.staged then
    table.insert(cmd, '--staged')
  end

  float.open {
    cmd = cmd,
    on_exit = vim.cmd.edit,
  }
end

vim.api.nvim_create_user_command('GRestore', restore, {})
vim.api.nvim_create_user_command('GRestoreStaged', function() restore { staged = true } end, {})

vim.keymap.set('n', '<leader>gs', ':GStatus<CR>', { silent = true })
vim.keymap.set('n', '<leader>ga', ':GAdd<CR>', { silent = true })
vim.keymap.set('n', '<leader>gr', ':GRestore<CR>', { silent = true })
vim.keymap.set('n', '<leader>grs', ':GRestoreStaged<CR>', { silent = true })
