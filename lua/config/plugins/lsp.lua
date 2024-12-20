-- for thoese basic default configs for the nvim lsp client for various lsp servers
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Lua LSP setup
      require("lspconfig").lua_ls.setup {}
    end,
  }
}
