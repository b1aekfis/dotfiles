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
keymap.set("t", "<a-s-w>", "<c-\\><c-n>")

-- diagnostic
keymap.set("n", "<c-j>", function() vim.diagnostic.goto_next() end, opts)
keymap.set("n", "<c-k>", function() vim.diagnostic.goto_prev() end, opts)
keymap.set("n", "QF", function() vim.diagnostic.setqflist() end, opts)

-- resize window
keymap.set("n", "<c-left>", "<c-w><")
keymap.set("n", "<c-right>", "<c-w>>")
keymap.set("n", "<c-up>", "<c-w>+")
keymap.set("n", "<c-down>", "<c-w>-")
