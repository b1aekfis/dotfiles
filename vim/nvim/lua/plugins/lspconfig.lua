return {
  "neovim/nvim-lspconfig",
  cmd = "LspStart",
  dependencies = {
    -- mason-lspconfig
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
        -- mason
        "williamboman/mason.nvim",
        opts = {} -- ensure setup
      },
      opts = {
        ensure_installed = { "clangd", "rust_analyzer", "lua_ls" },
      }
    },
    -- blink.cmp
    { "saghen/blink.cmp" },
    -- lazydev
    {
      "folke/lazydev.nvim",
      ft = "lua",
    },
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local nvim_lsp = require("lspconfig")
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    mason_lspconfig.setup_handlers({
      function(server)
        nvim_lsp[server].setup({
          capabilities = capabilities,
        })
      end,
      ["clangd"] = function()
        local is_windows = vim.fn.has('win32') == 1
        local gxx_path = vim.fn.systemlist((is_windows and "where g++" or "which g++"))[1] or ""
        local clangd_cmd = { 'clangd' }
        if gxx_path ~= "" then
          table.insert(clangd_cmd, "--query-driver=" .. gxx_path)
        end
        nvim_lsp["clangd"].setup({
          capabilities = capabilities,
          cmd = clangd_cmd,
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
