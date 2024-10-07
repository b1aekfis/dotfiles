return {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                always_divide_middle = true,
                component_separators = { left="|", right="|" },
                -- theme = require'lualine.themes.everforest',
            },
            sections = {
                lualine_x = {'encoding', 'filetype', 'location'},
                lualine_z = {"os.date('%I:%M %p')"},
            },
        })
    end,
}
