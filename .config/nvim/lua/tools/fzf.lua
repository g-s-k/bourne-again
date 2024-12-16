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
