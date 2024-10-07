local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- session
keymap.set("n", "SS", ":mkse! ~/ssnv/")
keymap.set("n", "SR", ":source ~/ssnv/")

-- buffer
keymap.set("n", "<s-tab>", ":b ", opts)

-- explorer
keymap.set("n", "<F2>", ":Ex<cr>", opts)

-- term
keymap.set("t", "<a-s-v>", "<c-\\><c-n>")

-- diagnostic
keymap.set("n", "<c-j>", function() vim.diagnostic.goto_next() end, opts)
keymap.set("n", "<c-k>", function() vim.diagnostic.goto_prev() end, opts)
