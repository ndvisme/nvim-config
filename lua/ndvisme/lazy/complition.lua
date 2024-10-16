return {
    "github/copilot.vim",
    config = function()
        -- Map leader cs to toggle Copilot
        vim.keymap.set('n', '<leader>cs', function()
            local copilot_enabled = vim.fn['copilot#Enabled']()
            if copilot_enabled == 1 then
                vim.cmd('Copilot disable')
                print("Copilot disabled")
            else
                vim.cmd('Copilot enable')
                print("Copilot enabled")
            end
            vim.cmd('Copilot status')
        end, { noremap = true, silent = false, desc = "Toggle Copilot" })
    end,
}
