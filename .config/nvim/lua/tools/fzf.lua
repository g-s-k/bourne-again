if vim.fn.isdirectory('/opt/homebrew/opt/fzf') ~= 0 then
  vim.opt.rtp:append { '/opt/homebrew/opt/fzf' }
end

local fzf_exe = vim.fn.exepath('fzf')
local nix_fzf_path = fzf_exe ~= ''
    and vim.fs.dirname(vim.fn.resolve(fzf_exe)) .. '/../share/vim-plugins/fzf'
    or ''

if vim.fn.isdirectory(nix_fzf_path) ~= 0 then
  vim.opt.rtp:append { nix_fzf_path }
end

if vim.env.TMUX then
  vim.g.fzf_layout = { tmux = '90%,60%' }
end

vim.keymap.set('n', '<leader>f', function()
  if vim.fs.root(0, { '.git' }) then
    vim.fn['fzf#run'](
      vim.fn['fzf#wrap']({
        source = 'git ls-files',
        sink = 'e',
      })
    )
  else
    vim.cmd('FZF')
  end
end, { silent = true })

vim.keymap.set('n', '<leader>b', function()
  local source = {}
  for _, v in pairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    if v.name ~= '' then
      table.insert(source, v.name)
    end
  end
  vim.fn['fzf#run'](
    vim.fn['fzf#wrap']({
      source = source,
      sink = 'b',
    })
  )
end, { silent = true })
