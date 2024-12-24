return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
        }
    },
    config = function()
        require('telescope').setup {
            pickers = {
                find_files = {
                    theme = "ivy",
                },
                help_tags = {
                    theme = "ivy",
                }
            }
        }

        pcall(require('telescope').load_extension, 'fzf') -- this makes the search faster!

        -- Your keymaps remain the same
        vim.keymap.set('n', '<space>fh', require('telescope.builtin').help_tags)
        vim.keymap.set('n', '<space>fd', require('telescope.builtin').find_files)
        vim.keymap.set('n', '<space>en', function()
            require('telescope.builtin').find_files {
                cwd = vim.fn.stdpath('config')
            }
        end, { desc = 'its conviniet to be able to edit config where ever and whenever' })
    end
}
