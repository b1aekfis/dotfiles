return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    ensure_installed = {
      "bash",
      "cpp",
      "css",
      "go",
      "javascript",
      "json",
      "lua",
      "powershell",
      "python",
      "rust",
      "toml",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
