return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",       -- completion sources for files in proj
      "hrsh7th/cmp-nvim-lua",   -- completion for neovim apis in your lua configs
      "hrsh7th/cmp-nvim-lsp",   -- better completion sources from every lsp
    },

    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.replace
          }),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item()
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer',  keyword_length = 8 },
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              nvim_lua = "[Lua]",
              luasnip = "[luasnip]",
            })[entry.source.name]

            -- make sure your terminal font supports the below icons
            -- would recommend installing a nerd font just to be safe
            vim_item.kind = ({
              Text          = ' Text',
              Method        = '󰆧 Method',
              Function      = '󰊕 Function',
              Constructor   = ' Constructor',
              Field         = ' Field',
              Variable      = ' Variable',
              Class         = ' Class',
              Interface     = ' Interface',
              Module        = ' Module',
              Property      = ' Property',
              Unit          = ' Unit',
              Value         = '󰎠 Value',
              Enum          = ' Enum',
              Keyword       = ' Keyword',
              Snippet       = ' Snippet',
              Color         = ' Color',
              File          = ' File',
              Reference     = ' Reference',
              Folder        = ' Folder',
              EnumMember    = ' EnumMember',
              Constant      = ' Constant',
              Struct        = ' Struct',
              Event         = ' Event',
              Operator      = ' Operator',
              TypeParameter = ' TypeParameter',
            })[vim_item.kind]
            return vim_item
          end,
        },
      })

    end
  },

}
