local files_cache
vim.api.nvim_create_autocmd('CmdlineEnter', { callback = function() files_cache = nil end })

function _G.find_files(arg, _)
  files_cache = files_cache or vim.fn.systemlist({ 'rg', '--files' })
  return arg == '' and files_cache or vim.fn.matchfuzzy(files_cache, arg)
end
vim.o.findfunc = 'v:lua.find_files'

vim.keymap.set('n', '<leader>f', ':find ')
vim.keymap.set('n', '<leader>b', ':b ')

local auto_complete_cmds = {
  b = true, buffer = true, sb = true,
  find = true, fin = true, sf = true,
  e = true, edit = true,
}
vim.api.nvim_create_autocmd('CmdlineChanged', {
  pattern = ':',
  callback = function()
    local cmd = vim.fn.getcmdline():match('^%s*(%a+)%s')
    if cmd and auto_complete_cmds[cmd] then
      vim.fn.wildtrigger()
    end
  end
})
