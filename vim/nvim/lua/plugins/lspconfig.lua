return {
  "neovim/nvim-lspconfig",
  cmd = "LspStart",
  dependencies = {
    -- mason
    {
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig.nvim"
      },
      opts = {}
    },
    -- cmp-nvim-lsp
    { "hrsh7th/cmp-nvim-lsp" },
    -- lazydev
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {}
    },
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local nvim_lsp = require("lspconfig")
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
      ["lua_ls"] = function()
        nvim_lsp["lua_ls"].setup({
          settings = {
            Lua = {
              diagnostics = {
                globals = {
                  'vim',
                },
              },
            },
          },
          capabilities = capabilities,
        })
      end,
      ["rust_analyzer"] = function()
        nvim_lsp["rust_analyzer"].setup({
          capabilities = capabilities,
        })
      end,
    })
  end,
}
