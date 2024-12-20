return {
  {
    'nvim-java/nvim-java',
    config = function()
      require('java').setup()
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  }
}
