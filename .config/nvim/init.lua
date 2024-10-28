-- appearance
vim.o.number = true
vim.o.relativenumber = true
vim.o.showtabline = 2

vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.signcolumn = 'yes'

-- behavior
vim.o.scrolloff = 8
vim.g.mapleader = ' '
vim.o.wrap = false

-- search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false

-- command / find completion
vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*.o', '*.rlib' }

-- tabs
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.expandtab = true

-- netrw file explorer
vim.g.netrw_fastbrowse = 0
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { silent = true })
vim.keymap.set('n', '<leader>y', '"+yy', { silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { silent = true })

-- navigation
vim.keymap.set('n', '<leader>e', ':25Lex<CR>', { silent = true })

vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', '<leader>x', ':tabclose<CR>', { silent = true })
vim.keymap.set('n', '[t', ':tabprev<CR>', { silent = true })
vim.keymap.set('n', ']t', ':tabnext<CR>', { silent = true })

vim.keymap.set('n', '[b', ':bprev<CR>', { silent = true })
vim.keymap.set('n', ']b', ':bnext<CR>', { silent = true })

vim.keymap.set('n', '<leader>q', function()
  local tabnr = vim.fn.tabpagenr()
  local window = vim.tbl_filter(function(t)
    return t.tabnr == tabnr and t.quickfix == 1 and t.loclist == 0
  end, vim.fn.getwininfo())[1]
  if window then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { silent = true })
vim.keymap.set('n', '[q', ':cprev<CR>', { silent = true })
vim.keymap.set('n', ']q', ':cnext<CR>', { silent = true })

vim.keymap.set('n', '<leader>l', function()
  -- TODO
  vim.cmd.lclose()
end, { silent = true })
vim.keymap.set('n', '[l', ':lprev<CR>', { silent = true })
vim.keymap.set('n', ']l', ':lnext<CR>', { silent = true })

-- surround (basic)
vim.keymap.set('v', 's(', 'c(<C-r>")<ESC>', { silent = true })
vim.keymap.set('v', 's)', 'c( <C-r>" )<ESC>', { silent = true })
vim.keymap.set('v', 's[', 'c[<C-r>"]<ESC>', { silent = true })
vim.keymap.set('v', 's]', 'c[ <C-r>" ]<ESC>', { silent = true })
vim.keymap.set('v', 's{', 'c{<C-r>"}<ESC>', { silent = true })
vim.keymap.set('v', 's}', 'c{ <C-r>" }<ESC>', { silent = true })

-- tmux
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


-- grep
vim.keymap.set('n', '<leader>g', function()
	vim.cmd.grep(vim.fn.expand('<cword>'))
	vim.cmd.copen()
end, { silent = true })

-- fzf
if vim.fn.isdirectory('/opt/homebrew/opt/fzf') ~= 0 then
	vim.opt.rtp:append { '/opt/homebrew/opt/fzf' }
end

local nix_fzf_path = string.gsub(
	vim.fn.system {
		'sh', '-c', 'realpath "$(which fzf)/../../share/vim-plugins/fzf"'
	},
	'(.-)%s*$',
	'%1'
)
if vim.fn.isdirectory(nix_fzf_path) ~= 0 then
	vim.opt.rtp:append { nix_fzf_path }
end

if vim.env.TMUX then
	vim.g.fzf_layout = { tmux = '90%,60%' }
end

vim.keymap.set('n', '<leader>f', ':FZF<CR>', { silent = true })
vim.keymap.set('n', '<leader>b', function()
	local source = {}
	for k,v in pairs(vim.fn.getbufinfo({buflisted = 1})) do
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

-- lsp

vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { silent = true })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setqflist, { silent = true })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.supports_method('textDocument/codeAction') then
			vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { silent = true })
		end
		if client.supports_method('textDocument/definition') then
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
		end
		if client.supports_method('textDocument/formatting') then
			vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, { silent = true })
		end
		if client.supports_method('textDocument/implementation*') then
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
		end
		if client.supports_method('textDocument/references') then
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true })
		end
		if client.supports_method('textDocument/rename') then
			vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { silent = true })
		end
	end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'c', 'cpp'},
  callback = function(ev)
    vim.lsp.start({
      name = 'clangd',
      cmd = {'clangd', '--clang-tidy'},
      root_dir = vim.fs.root(ev.buf, {'CMakeLists.txt', 'Makefile', 'README.md'}),
    })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function(ev)
    vim.lsp.start({
      name = 'rust-analyzer',
      cmd = {'rust-analyzer'},
      root_dir = vim.fs.root(ev.buf, {'Cargo.lock'}),
    })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'zig',
  callback = function(ev)
    vim.lsp.start({
      name = 'zls',
      cmd = {'zls'},
      root_dir = vim.fs.root(ev.buf, {'build.zig'}),
    })
  end
})
