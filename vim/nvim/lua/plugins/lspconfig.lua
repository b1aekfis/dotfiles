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
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    vim.lsp.config("clangd", {
      capabilities = capabilities,
      cmd = (function()
        local is_windows = vim.fn.has('win32') == 1
        local gxx_path = vim.fn.systemlist((is_windows and "where g++" or "which g++"))[1] or ""
        local clangd_cmd = { "clangd" }
        if gxx_path ~= "" then
          table.insert(clangd_cmd, "--query-driver=" .. gxx_path)
        end
        return clangd_cmd
      end)(),
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
    })

    require("mason").setup()

    require("mason-lspconfig").setup {
      ensure_installed = { "clangd", "rust_analyzer", "lua_ls" },
      automatic_enable = false
    }
  end,
}
