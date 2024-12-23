-- on_attach.lua
local buf = vim.lsp.buf


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

  -- Mappings
  vim.keymap.set('n', 'gD', buf.declaration, extend(opts, { desc = "Buffer declarations" }))
  vim.keymap.set('n', 'gd', buf.definition, extend(opts, { desc = "Go to definition" }))
  vim.keymap.set('n', 'K', buf.hover, extend(opts, { desc = "View definition" }))
  vim.keymap.set('n', 'gi', buf.implementation, extend(opts, { desc = "Get implementation" }))
  vim.keymap.set('n', 'SH', buf.signature_help, extend(opts, { desc = "Signature help" }))
  vim.keymap.set('n', '<space>wa', buf.add_workspace_folder, extend(opts, { desc = "Add workspace to folder" }))
  vim.keymap.set('n', '<space>wr', buf.remove_workspace_folder, extend(opts, { desc = "remove workspace from folder" }))
  vim.keymap.set('n', '<space>wl', buf.list_workspace_folders, extend(opts, { desc = "List workspace folders" }))
  vim.keymap.set('n', '<space>D', buf.type_definition, extend(opts, { desc = "Type definition" }))
  vim.keymap.set('n', '<space>rn', buf.rename, extend(opts, { desc = "Rename" }))
  vim.keymap.set('n', '<space>ca', buf.code_action, extend(opts, { desc = "Code action" }))
  vim.keymap.set('n', 'gr', buf.references, extend(opts, { desc = "Get references" }))
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, extend(opts, { desc = "Open diagnostic on current line" }))
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, extend(opts, { desc = "Jump to next diagnostic" }))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, extend(opts, { desc = "Jump to previous diagnostic" }))
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, extend(opts, { desc = "Format file" }))

end
