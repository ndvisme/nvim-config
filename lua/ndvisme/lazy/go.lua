return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("go").setup({
      lsp_cfg = true,
      lsp_gofumpt = true,
      lsp_on_attach = true,
      gopls_cmd = {"gopls"},
      gopls_remote_auto = true,
      gofmt = "gofumpt",
    })
  end,
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()'
}
