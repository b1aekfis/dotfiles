return {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        local custom_everforest = require'lualine.themes.everforest'
        local ter = custom_everforest.terminal
        ter.a.bg = '#7fbbb3'
        require("lualine").setup({
            options = {
                icons_enabled = true,
                -- always_divide_middle = true,
                theme = custom_everforest,
            },
        })
    end,
}
