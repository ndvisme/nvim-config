return {
	{
		"hrsh7th/nvim-cmp", -- Main completion plugin
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer source
			"hrsh7th/cmp-path", -- File path source
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
			"rafamadriz/friendly-snippets", -- Predefined snippets
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				performance = {},
			})

			-- Load VSCode-like snippets from friendly-snippets
			require("luasnip/loaders/from_vscode").lazy_load()

			vim.opt.completeopt = { "menu", "menuone", "noselect" }

			return {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For expanding snippets
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP source
					{ name = "luasnip" }, -- Snippet source
					{ name = "buffer" }, -- Buffer source
					{ name = "path" }, -- File path source
				}),
			}
		end,
	},
}
