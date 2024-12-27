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
		require('telescope').setup({
			defaults = require('telescope.themes').get_ivy(),
		})

		pcall(require('telescope').load_extension, 'fzf') -- this makes the search faster!

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<space>gc', builtin.git_commits)
		vim.keymap.set('n', '<space>fh', builtin.help_tags, { desc = 'get nvim cmds help' })
		vim.keymap.set('n', '<space>fm', builtin.man_pages, { desc = 'see cmnds help of apps' })
		vim.keymap.set('n', '<space>fd', builtin.find_files)
		vim.keymap.set('n', '<space>fb', builtin.buffers)
		vim.keymap.set('n', '<space>fg', builtin.live_grep)

		vim.keymap.set('n', '<leader>ff', function()
			builtin.find_files({ cwd = vim.fn.expand('%:p:h') })
		end, { desc = 'Find files in current directory' })

		vim.keymap.set('n', '<space>en', function()
			builtin.find_files({
				cwd = vim.fn.stdpath('config')
			})
		end, { desc = 'its convinient to be able to edit config where ever and whenever' })
	end
}
