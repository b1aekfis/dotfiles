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
                always_divide_middle = true,
                component_separators = { left="|", right="|" },
                theme = custom_everforest,
            },
            sections = {
                lualine_x = {'encoding', 'filetype', 'location'},
                lualine_z = {"os.date('%I:%M %p')"},
            }
        })
    end,
}
