return {
    {
        'tpope/vim-dadbod',
        dependencies = {
            'kristijanhusak/vim-dadbod-ui',
            'kristijanhusak/vim-dadbod-completion',
        },
        config = function()
            vim.g.db_ui_use_nerd_fonts = 1
            
            -- Add autocmd for SQL files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "sql",
                    "mysql",
                    "plsql",
                },
                callback = function()
                    vim.opt_local.omnifunc = "vim_dadbod_completion#omni"
                end
            })
        end,
    }
}
