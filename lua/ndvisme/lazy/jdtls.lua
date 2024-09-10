return {
    "mfussenegger/nvim-jdtls",

    ft = "java",

    config = function()
        local jdtls = require('jdtls')

        local root_markers = {'gradlew', 'mvnw', '.git'}
        local root_dir = require('jdtls.setup').find_root(root_markers)

        local home = os.getenv('HOME')
        local jdtls_path = home .. '/.local/share/nvim/mason/packages/jdtls'

        local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
        local config = {
            cmd = {
                'java',
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-Xmx1g',
                '--add-modules=ALL-SYSTEM',
                '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
                '-configuration', '/path/to/jdtls/config_mac',
                '-data', workspace_folder,
            },
            root_dir = root_dir,
            settings = {
                java = {
                    -- Configure Java settings here
                }
            },
            init_options = {
                bundles = {}
            },
        }

        -- Attach JDTLS for Java files
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                jdtls.start_or_attach(config)
            end,
        })

        -- Set up any keybindings or additional configuration here
        vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, { buffer = true })
        vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, { buffer = true })
        vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, { buffer = true })
        vim.keymap.set('n', '<leader>jm', jdtls.extract_method, { buffer = true })
    end
}
