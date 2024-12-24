-- for navigation the file systems
return { {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	config = function()
		require('telescope').setup {
			pickers = {
				find_files = {
					theme = "ivy", -- this shows more data when looking for files
				},
				help_tags = {
					theme = "ivy", -- this shows more data when looking for files
				}
			}
		}
		vim.keymap.set('n', '<space>fh', require('telescope.builtin').help_tags)
		vim.keymap.set('n', '<space>fd', require('telescope.builtin').find_files)
		vim.keymap.set('n', '<space>en', function()
			require('telescope.builtin').find_files {
				cwd = vim.fn.stdpath('config')
			}
		end, { desc = 'its conviniet to be able to edit config where ever and whenever' })
	end,
}
}
