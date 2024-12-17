local M = {}

function M.get_pager()
  if vim.fn.executable('delta') then
    return 'delta --paging=always'
  elseif vim.env.PAGER then
    return vim.env.PAGER
  else
    return 'less -R'
  end
end

return M
