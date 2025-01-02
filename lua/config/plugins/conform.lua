return {
	{
		'stevearc/conform.nvim',
		opts = {
			formatters_by_ft = {
				java = { "google-java-format" },
				python = { "black" },
				lua = { "stylua" },
			}
		},
	}
}
