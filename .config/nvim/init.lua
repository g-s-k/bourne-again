require("core.opts")
require("core.mappings")

require("tools.fzf")
require('tools.git')
require("tools.grep")
require("tools.lsp")
require("tools.tmux")

vim.api.nvim_create_user_command('Top', function()
  require("util.float").run_shell {
    cmd = vim.fn.executable('htop') and 'htop' or 'top',
  }
end, {})
