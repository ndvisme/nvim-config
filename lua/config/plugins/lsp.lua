return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
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
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig").lua_ls.setup({ capabilites = capabilities })

			require("lspconfig").gopls.setup({
				capabilities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
			})

			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
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

					vim.keymap.set("n", "<space>f", function()
						require("conform").format()
					end)
					vim.keymap.set("v", "<space>f", function()
						require("conform").format({
							async = false,
							timeout_ms = 500,
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
