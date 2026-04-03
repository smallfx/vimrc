vim.pack.add({
	'https://github.com/itchyny/landscape.vim',
	'https://github.com/tpope/vim-surround',
	'https://github.com/qpkorr/vim-bufkill',
	'https://github.com/tpope/vim-fugitive',
	'https://github.com/neovim/nvim-lspconfig',
	{ src = 'https://github.com/Saghen/blink.cmp', version = vim.version.range('*') }, -- need the funny version arg for binary stuff?
	'https://github.com/itchyny/lightline.vim',
	'https://github.com/linrongbin16/lsp-progress.nvim',
})

require('lspprog').setup()

vim.lsp.config('clangd', { cmd = {'clangd', '--background-index'} })
vim.lsp.enable('clangd')
vim.lsp.enable('tsgo')

require('blink.cmp').setup({
	keymap = { preset = 'enter' },
	cmdline = { enabled = true },
	completion = {
		documentation = { auto_show = true }
	},
	sources = {
		default = { 'lsp', 'path', 'buffer' }
	}
})
