return {
    "akinsho/toggleterm.nvim",
    version = "*", 
    config = function()
        require("toggleterm").setup({
            size = 10,
            open_mapping = [[<F7>]],
            hide_numbers = true, -- hide the number column in toggleterm buffers
            close_on_exit = true,
            direction = horizontal,
            shell = vim.o.shell,
            shade_terminals = false,
        })
    end,
}
