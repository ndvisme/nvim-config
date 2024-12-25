
-- custom extend function so that we are not repeating the opt in a bunch of places
local opts = { noremap = true, silent = true, }
local extend = function(tbl, desc)
  return vim.tbl_extend("error", tbl, desc)
end

-- these keymaps will work only if a language server can be attached to the current buffer
return function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

  -- handlers
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single", color = "red" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, extend(opts, { desc = "Jump to next diagnostic" }))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, extend(opts, { desc = "Jump to previous diagnostic" }))

end
