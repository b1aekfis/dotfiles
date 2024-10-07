return {
      "sainnhe/everforest",
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.everforest_enable_italic = true 
        vim.g.everforest_dim_inactive_windows = false 
        -- vim.g.everforest_transparent_background = 2
        vim.g.everforest_spell_foreground = 'colored'
        vim.g.everforest_diagnostic_text_highlight = true
        vim.g.everforest_diagnostic_line_highlight = true

        vim.cmd.colorscheme("everforest")
      end
}
