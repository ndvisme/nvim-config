return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp", -- Autocompletion plugin
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"williamboman/mason.nvim", -- LSP manager
			"williamboman/mason-lspconfig.nvim", -- Mason integration with lspconfig
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason").setup()
			require("mason-lspconfig").setup()

			-- Setup Lua language server
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- Setup Go language server
			lspconfig.gopls.setup({
				capabilities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
			})

			-- Setup Python language server
			lspconfig.pyright.setup({
				settings = {
					pyright = {
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							ignore = { "*" },
						},
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					vim.keymap.set({ "n", "v" }, "<leader>f", function()
						require("conform").format({
							async = true,
							lsp_fallback = true,
						})
					end)

					vim.keymap.set("n", "<space>gD", function()
						vim.lsp.buf.declaration()
					end)
					vim.keymap.set("n", "<space>gd", function()
						vim.lsp.buf.definition()
						vim.cmd("normal! zz")
					end)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end)
					vim.keymap.set("n", "<space>gi", function()
						vim.lsp.buf.implementation()
					end)
					vim.keymap.set("n", "<space>gr", function()
						vim.lsp.buf.references()
					end)

					vim.keymap.set("n", "<space>rn", function()
						vim.lsp.buf.rename()
					end)
					vim.keymap.set("n", "<space>ca", function()
						vim.lsp.buf.code_action()
					end)
				end,
			})
		end,
	},
}
