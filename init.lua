print("hello from init")

require("config.lazy")


-- These keymaps make development much more quicker
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true


vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "high light when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function ()
		vim.highlight.on_yank()
	end,
})
