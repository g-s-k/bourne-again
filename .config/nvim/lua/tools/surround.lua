local function surround(open, close)
  local mode = vim.fn.mode()
  if mode == '\22' then
    vim.notify("Surround does not support blockwise selections.",
      vim.log.levels.WARN)
  end

  -- get the selection ends and ensure they are in ascending order
  local s = vim.fn.getpos('v')
  local e = vim.fn.getpos('.')
  if s[2] > e[2] or (s[2] == e[2] and s[3] > e[3]) then
    s, e = e, s
  end

  -- convert to 0-based row, byte column
  local srow, scol = s[2] - 1, s[3] - 1
  local erow = e[2] - 1
  local eline = vim.fn.getline(e[2])
  local ecol = #eline
  if mode == 'V' then
    scol = 0
  else
    -- ensure all bytes of the last character are included
    local last_char = vim.fn.strpart(eline, e[3] - 1, 1, true)
    ecol = math.min(e[3] - 1 + #last_char, ecol)
  end

  -- exit Visual mode
  vim.api.nvim_feedkeys(vim.keycode('<ESC>'), 'nx', false)

  vim.api.nvim_buf_set_text(0, erow, ecol, erow, ecol, { close })
  vim.api.nvim_buf_set_text(0, srow, scol, srow, scol, { open })
end

local surround_pairs = {
  ['('] = { '(', ')' },
  [')'] = { '( ', ' )' },
  ['['] = { '[', ']' },
  [']'] = { '[ ', ' ]' },
  ['{'] = { '{', '}' },
  ['}'] = { '{ ', ' }' },
  ['<'] = { '<', '>' },
  ['>'] = { '< ', ' >' },
  ['"'] = { '"', '"' },
  ["'"] = { "'", "'" },
  ['`'] = { '`', '`' },
}
for key, pair in pairs(surround_pairs) do
  vim.keymap.set('x', 's' .. key, function() surround(pair[1], pair[2]) end, { silent = true })
end
