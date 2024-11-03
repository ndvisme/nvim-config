return {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
        require('rose-pine').setup({
            -- Optional configuration
            variant = 'main', -- auto, main, moon, or dawn
            dark_variant = 'main',
            styles = {
                transparency = false,
                italic = true,
                bold = true
            }
        })
        -- Set colorscheme after options
        vim.cmd('colorscheme rose-pine')
    end,
    priority = 1000 -- Load this before other plugins
}
