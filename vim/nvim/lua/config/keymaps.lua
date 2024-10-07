local opts = { noremap = true, silent = true }

-- session
local src = " ~/ssv/"
vim.keymap.set("n", "SS", ":mkse!" .. src)
vim.keymap.set("n", "SR", ":source" .. src)

-- diagnostic
vim.keymap.set("n", "<c-j>", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "<c-k>", function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set("n", "QF", function() vim.diagnostic.setqflist() end, opts)

-- tabline
vim.keymap.set("n", "<Leader>B", function() vim.o.showtabline = vim.o.showtabline ~= 2 and 2 or 0 end, opts)

-- fzf
vim.keymap.set("n", "<Leader>ff", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>Ff", "<Cmd>FzfLua files cwd=~<CR>") -- user files

-- Lazy
vim.keymap.set("n", "<Leader>lz", "<Cmd>Lazy<CR>")

-- buffer
vim.keymap.set("n", "[b", "<Cmd>bp<CR>", opts)
vim.keymap.set("n", "]b", "<Cmd>bn<CR>", opts)

-- window
vim.keymap.set("n", "sh", "<c-w>h", opts)
vim.keymap.set("n", "sj", "<c-w>j", opts)
vim.keymap.set("n", "sk", "<c-w>k", opts)
vim.keymap.set("n", "sl", "<c-w>l", opts)
vim.keymap.set("n", "sw", "<c-w>w", opts)

-- explorer
vim.keymap.set("n", "<F2>", "<Cmd>Ex<CR>", opts)

-- wt
vim.keymap.set("n", "<Leader>wt",
  function()
    vim.cmd([[!wt -w 0 nt --title vim -d ]] .. vim.fn.expand('%:p:h'))
  end, opts)

vim.keymap.set("n", "<F7>",
  function()
    vim.cmd([[!wt -w 0 sp -H --title vim -d ]] .. vim.fn.expand('%:p:h'))
  end, opts)

-- term
vim.keymap.set("t", "<a-s-w>", "<c-\\><c-n>")

-- resize window
vim.keymap.set("n", "<c-left>", "<c-w><")
vim.keymap.set("n", "<c-right>", "<c-w>>")
vim.keymap.set("n", "<c-up>", "<c-w>+")
vim.keymap.set("n", "<c-down>", "<c-w>-")

-- zz
vim.keymap.set({ "n", "v" }, "zj", "Lzz")
vim.keymap.set({ "n", "v" }, "zk", "Hzz")
