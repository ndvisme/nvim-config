return {
	{
		"github/copilot.vim",
		cmd = "Copilot",
		lazy = true,
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

			vim.api.nvim_create_autocmd("VimEnter", {
				desc = "I want help only when I invoke it",
				command = "Copilot disable",
			})
		end,
	}
}
