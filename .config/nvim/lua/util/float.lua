local shell = require('util.shell')

local M = {}

function M.open(opts)
  opts = opts or {}

  -- Create an immutable scratch buffer that is wiped once hidden
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  -- Create a floating window using the scratch buffer
  local height = math.ceil(vim.o.lines * (opts.height or 0.8))
  local width = math.ceil(vim.o.columns * (opts.width or 0.8))
  local win = vim.api.nvim_open_win(buf, true, {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = math.ceil((vim.o.lines - height) / 2),
    col = math.ceil((vim.o.columns - width) / 2),
    border = "single",
  })

  -- Change to the new window
  vim.api.nvim_set_current_win(win)

  -- Run a command.
  if opts.cmd then
    local cmd = type(opts.cmd) == "table" and opts.cmd or { opts.cmd }
    vim.fn.termopen(cmd, {
      on_exit = function(_, _, _)
        if opts.remain then
          return
        end

        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end

        if opts.on_exit then
          opts.on_exit()
        end
      end
    })

    vim.cmd.startinsert()
  elseif opts.edit then
    vim.cmd.edit(opts.edit)
  else
    vim.api.nvim_win_close(win, true)
    vim.notify("No command or file name provided.", vim.log.levels.ERROR)
  end
end

function M.run_shell(opts)
  opts = opts or {}

  local cmd = opts.cmd

  if opts.use_pager then
    cmd = cmd .. ' | ' .. shell.get_pager()
  end

  M.open { cmd = { 'sh', '-c', cmd } }
end

return M
