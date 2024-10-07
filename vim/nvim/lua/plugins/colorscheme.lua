return {
      "sainnhe/everforest",
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.everforest_enable_italic = true 
        vim.g.everforest_dim_inactive_windows = false 
        -- vim.g.everforest_transparent_background = 2

        vim.cmd.colorscheme("everforest")
      end
}
