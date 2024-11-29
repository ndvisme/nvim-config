-- CR --> carriage return == the enter action
-- '> --> Represents the end of the visual selection
-- '< --> represents the start of the visual selection
-- = --> Reindents the line
-- m --> Mark. Act like bookmarks that allow u to save specific positions in txt & jump back to them later
--		` --> Jumps to the exact line & column position of the mark
--		' --> Jumps to the beggining of the line containing the mark
-- <C-x> --> ctrl + x
-- <cmd> --> Indicates a command line command
-- [[ ]] --> Prevents escape char issues. Protection against special chars. More reliable way of handling chars
-- + --> Represents the system clipboard register
-- <nop> --> No operation
-- buffer --> tmp space in memory that holds the content of an opened file for editing
-- quickfix list --> Compile errs, linter errs, search results & more...
-- % --> Represents current file path

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)                   -- Project View
vim.keymap.set("n", "<leader>pb", "<CMD>Telescope buffers<CR>") -- Project Buffer

-- This moves the selected lines in visual mode up or down a line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- In normal mode join lines while keeping the the cursor in its original position
-- cmd operations --> mark & save in z. Join lines. jump to exact mark position.
vim.keymap.set("n", "J", "mzJ`z")

-- In normal mode goes down half a page & than position the cursor in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- When searching for a pattern in normal mode, this goes to the next/previous occurnce.
-- cmd operation --> next pattern match. cursor in middle of screen. open any folds in the cursor position
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Restarts the language server protocol (LSP)
-- operations --> cmd line cmd. LspRestart. enter
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Paste over selected text without copying the deleted text to the register
vim.keymap.set("v", "<leader>p", [["_dP]])

-- Yank txt to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Yanks the entire line to the systems clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- In normal & visual mode pastes the txt from the systems clipboard
vim.keymap.set({"n", "v"}, "<leader>p", [["+P]])

-- Deletes the highlighted txt to the black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Escape using ctrl+c from insert mode
vim.keymap.set("i", "<C-c>", "<Esc>") -- To remove?

-- Makes the Q in normal mode to do nothing
vim.keymap.set("n", "Q", "<nop>")

-- Format the current buffer (file) using the languge server protocal (LSP)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- In visual mode, formates the highlighted txt using the LSP
vim.keymap.set('v', '<leader>f', function()
	vim.lsp.buf.format({
		range = {
			["start"] = vim.api.nvim_buf_get_mark(0, "<"),
			["end"] = vim.api.nvim_buf_get_mark(0, ">")
		}
	})
end)

-- Navigate to the next/prev item in the quickfix list while keeping the cursor in the middle of the screen
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- Similar to the above cmd but specific to the current window
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set('n', 'K', vim.lsp.buf.hover)

-- Searches in current file by regex
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- "make it rain" animation
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- Source (reload) the current file
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
