-- To make my code nice & formatted
return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				java = { "google-java-format" },
				python = { "black" },
				lua = { "stylua" },
				sql = { "pg_format" },
			},
		},
	},
}
