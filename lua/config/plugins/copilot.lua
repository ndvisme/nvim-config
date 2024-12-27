return {
	{
		"github/copilot.vim",
		cmd = "Copilot",
		lazy = true,
		config = function()
			-- Disable default mapping
			vim.g.copilot_no_tab_map = true
			vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		end,
	}
}
