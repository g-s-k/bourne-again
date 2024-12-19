-- appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showtabline = 1

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.signcolumn = 'yes'

-- behavior
vim.opt.scrolloff = 8
vim.g.mapleader = ' '
vim.opt.wrap = false

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- command / find completion
vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*.o', '*.rlib' }

-- tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- netrw file explorer
vim.g.netrw_fastbrowse = 0
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- folding
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4
vim.opt.foldtext = ""
vim.opt.foldmethod = "syntax"
