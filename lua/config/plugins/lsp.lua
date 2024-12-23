-- for thoese basic default configs for the nvim lsp client for various lsp servers
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
	  library = {
	    -- See the configuration section for more details
	    -- Load luvit types when the `vim.uv` word is found
	    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
	  },
	},
      },
    },
    config = function()
	require("lspconfig").lua_ls.setup {}


      vim.keymap.set('n', '<space>gD', function() vim.lsp.buf.declaration() end)
      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format() end)
    end,
  }
}
