return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		-- Define the custom formatter that converts spaces to tabs
		conform.formatters.spaces_to_tabs = {
			meta = {
				url = nil,
				description = "Run google-java-format and then convert spaces to tabs",
			},
			-- Inherit from google-java-format
			inherit = false,
			-- Command will be the same as google-java-format
			command = "google-java-format",
			args = { "--aosp", "$FILENAME" },
			-- Custom formatting function that post-processes the output
			format = function(self, content, range)
				-- First format with google-java-format by calling the command
				local result_with_spaces = conform.formatters._run_formatter(
					content,
					self,
					nil, -- stdin
					range
				)

				if not result_with_spaces then
					return nil
				end

				-- Then replace spaces with tabs
				local result_with_tabs = {}
				local spaces_per_tab = 4 -- Adjust to match your tab settings
				local pattern = "^" .. string.rep(" ", spaces_per_tab)

				for _, line in ipairs(result_with_spaces) do
					-- Replace leading spaces with tabs
					local modified_line = line
					while modified_line:match("^" .. string.rep(" ", spaces_per_tab)) do
						modified_line = modified_line:gsub("^" .. string.rep(" ", spaces_per_tab), "\t")
					end
					table.insert(result_with_tabs, modified_line)
				end

				return result_with_tabs
			end,
		}

		conform.setup({
			formatters_by_ft = {
				java = { "spaces_to_tabs" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				sql = { "pg_format" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				sh = { "beautysh" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
