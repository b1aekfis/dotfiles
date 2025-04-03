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
vim.o.showtabline = 0
_G.hide_tabline = true
vim.keymap.set("n", "<Leader>B",
  function()
    _G.hide_tabline = not _G.hide_tabline
    vim.o.showtabline = _G.hide_tabline and 0 or 2
  end, opts)

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

if vim.fn.has('win32') == 1 then
  -- wt
  vim.keymap.set("n", "<Leader>wt",
    function()
      vim.cmd([[!wt -w 0 nt --title vim -d ]] .. vim.fn.expand('%:p:h'))
    end, opts)

  vim.keymap.set("n", "<F7>",
    function()
      vim.cmd([[!wt -w 0 sp -H --title vim -d ]] .. vim.fn.expand('%:p:h'))
    end, opts)

  -- lazygit
  vim.keymap.set("n", "<Leader>gg",
    function()
      vim.cmd([[!wt -w 0 nt -p PowerShell -d ]] .. vim.fn.expand('%:p:h') .. [[ lazygit]])
    end, opts)
end

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
