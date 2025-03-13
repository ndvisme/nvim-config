require("config.lazy")

-- These remaps make development much more quicker
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "to make nav and display more convinient" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "to make nav and display more convinient" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "When I move the page, i like to be centered." })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "When I move the page, i like to be centered." })

vim.keymap.set("n", "<Leader>fj", "<Cmd>%!jq<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("SeeTabsAndSpaces", function(opts)
	if opts.fargs[1] == 't' or #opts.fargs == 0 then
		vim.cmd("set list")
	elseif opts.fargs[1] == 'f' then
		vim.cmd("set nolist")
	else
		print("Invalid arg. Use 't' to show tabs & spaces & 'f' to hide them.")
	end
end, { nargs = "?" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "high light when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
