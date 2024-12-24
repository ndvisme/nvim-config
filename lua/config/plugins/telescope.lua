return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
		}
	},
	config = function()
		require('telescope').setup {
			defaults = require('telescope.themes').get_ivy()
		}

		pcall(require('telescope').load_extension, 'fzf') -- this makes the search faster!

		vim.keymap.set('n', '<space>gc', require('telescope.builtin').git_commits)
		vim.keymap.set('n', '<space>fh', require('telescope.builtin').help_tags, { desc = 'get nvim cmds help' })
		vim.keymap.set('n', '<space>fm', require('telescope.builtin').man_pages, { desc = 'see cmnds help of apps' })
		vim.keymap.set('n', '<space>fd', require('telescope.builtin').find_files)
		vim.keymap.set('n', '<space>fg', require('telescope.builtin').live_grep)

		vim.keymap.set('n', '<space>en', function()
			require('telescope.builtin').find_files {
				cwd = vim.fn.stdpath('config')
			}
		end, { desc = 'its conviniet to be able to edit config where ever and whenever' })
	end
}
