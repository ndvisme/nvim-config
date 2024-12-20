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
      -- JDTLS setup
      require("lspconfig").jdtls.setup({
        cmd = {'jdtls'},
        root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = vim.fn.expand("$JAVA_HOME"),
                }
              }
            }
          }
        },
      })
    end,
  }
}
