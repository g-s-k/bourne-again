local function get_diagnostics()
  local params = vim.lsp.util.make_position_params()
  local bufnr = vim.uri_to_bufnr(params.textDocument.uri)
  local diag_list

  if vim.lsp.util.diagnostics_by_buf then
    diag_list = vim.lsp.util.diagnostics_by_buf[bufnr]
  end

  if not diag_list then
    print("No diagnostic messages found for this buffer.")
  end

  return {
    line = params.position.line,
    uri = params.textDocument.uri,
    list = diag_list,
  }
end

local function jump_to(uri, range)
  if range then
    vim.lsp.util.jump_to_location({ uri = uri, range = range, })
  end
end

local function next_diagnostic()
  local params = get_diagnostics()
  if not params.list then return end

  local line = params.line
  local first, current

  -- they are not sorted, must iterate over all
  for _, d in ipairs(params.list) do
    local d_line = d.range.start.line

    if d_line > line and (not current or d_line < current.start.line) then
        current = d.range
    end

    if not first or d_line < first.start.line then
      first = d.range
    end
  end

  jump_to(params.uri, current or first)
end

local function previous_diagnostic()
  local params = get_diagnostics()
  if not params.list then return end

  local line = params.line
  local last, current

  -- they are not sorted, must iterate over all
  for _, d in ipairs(params.list) do
    local d_line = d.range.start.line

    if d_line < line and (not current or d_line > current.start.line) then
        current = d.range
    end

    if not last or d_line > last.start.line then
      last = d.range
    end
  end

  jump_to(params.uri, current or last)
end

return {
  next_diagnostic = next_diagnostic,
  previous_diagnostic = previous_diagnostic,
}
