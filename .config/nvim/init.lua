-- appearance
vim.o.number = true
vim.o.showtabline = 2

vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.signcolumn = 'yes'

-- behavior
vim.o.scrolloff = 10
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

-- netrw file explorer
vim.g.netrw_fastbrowse = 0
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- system clipboard
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>y', '"+yy')
vim.keymap.set('n', '<leader>p', '"+p')

-- navigation
vim.keymap.set('n', '<leader>e', ':25Lex<CR>')

vim.keymap.set('n', '<leader>t', ':tabnew<CR>')
vim.keymap.set('n', '<leader>x', ':tabclose<CR>')
vim.keymap.set('n', '[t', ':tabprev<CR>')
vim.keymap.set('n', ']t', ':tabnext<CR>')

vim.keymap.set('n', '[b', ':bprev<CR>')
vim.keymap.set('n', ']b', ':bnext<CR>')

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
end)
vim.keymap.set('n', '[q', ':cprev<CR>')
vim.keymap.set('n', ']q', ':cnext<CR>')

vim.keymap.set('n', '<leader>l', function()
  -- TODO
  vim.cmd.lclose()
end)
vim.keymap.set('n', '[l', ':lprev<CR>')
vim.keymap.set('n', ']l', ':lnext<CR>')

-- surround (basic)
vim.keymap.set('v', 's(', 'c(<C-r>")<ESC>')
vim.keymap.set('v', 's)', 'c( <C-r>" )<ESC>')
vim.keymap.set('v', 's[', 'c[<C-r>"]<ESC>')
vim.keymap.set('v', 's]', 'c[ <C-r>" ]<ESC>')
vim.keymap.set('v', 's{', 'c{<C-r>"}<ESC>')
vim.keymap.set('v', 's}', 'c{ <C-r>" }<ESC>')

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

vim.keymap.set('n', '<C-h>', function() try_navigate_panes('h') end)
vim.keymap.set('n', '<C-j>', function() try_navigate_panes('j') end)
vim.keymap.set('n', '<C-k>', function() try_navigate_panes('k') end)
vim.keymap.set('n', '<C-l>', function() try_navigate_panes('l') end)


-- grep
vim.keymap.set('n', '<leader>g', function()
	vim.cmd.grep(vim.fn.expand('<cword>'))
	vim.cmd.copen()
end)

-- fzf
if vim.fn.isdirectory('/opt/homebrew/opt/fzf') then
	vim.opt.rtp:append { '/opt/homebrew/opt/fzf' }

	vim.keymap.set('n', '<leader>f', ':FZF<CR>')
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
	end)
end

-- lsp

vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>D', vim.diagnostic.setqflist)

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.supports_method('textDocument/codeAction') then
			vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
		end
		if client.supports_method('textDocument/definition') then
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
		end
		if client.supports_method('textDocument/formatting') then
			vim.keymap.set('n', '<leader>F', vim.lsp.buf.format)
		end
		if client.supports_method('textDocument/implementation*') then
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
		end
		if client.supports_method('textDocument/references') then
			vim.keymap.set('n', 'gr', vim.lsp.buf.references)
		end
		if client.supports_method('textDocument/rename') then
			vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
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
      root_dir = vim.fs.root(ev.buf, {'Cargo.toml'}),
    })
  end
})
