return {
    -- lsp server
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "hrsh7th/cmp-nvim-lsp",

        { "folke/lazydev.nvim", opts = {} },

    },
    config = function()

        local mason_lspconfig = require("mason-lspconfig")

        local nvim_lsp =  require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
                
        mason_lspconfig.setup_handlers({
                function(server)
                    nvim_lsp[server].setup({
                        capabilities = capabilities,
                    })
                end,
                ["clangd"] = function()
                    nvim_lsp["clangd"].setup({
                        capabilities = capabilities,
                    })
                end,
        }) 
    end,
}
