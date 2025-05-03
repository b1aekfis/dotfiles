local editor = {}
editor.color = require 'editor.color'
editor.session = require 'editor.session'

-- load/save the session through the prompt
vim.keymap.set("n", "SS", function() editor.session.prompt() end)

-- diagnostic
vim.keymap.set("n", "<c-j>", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "<c-k>", function() vim.diagnostic.goto_prev() end)
vim.keymap.set("n", "QF", function() vim.diagnostic.setqflist(--[[all buffers]]) end)
vim.keymap.set("n", "Qf", function() vim.diagnostic.setloclist(--[[cur buffer]]) end)

-- toggle tabline
vim.o.showtabline = 0
_G.hide_tabline = true
vim.keymap.set("n", "<Leader>T", function()
  _G.hide_tabline = not _G.hide_tabline
  vim.o.showtabline = _G.hide_tabline and 0 or 2
end)

-- inspect color codes in the current line
vim.keymap.set("n", "<Leader>cc", function()
  editor.color.inspect_line()
end)

 -- stop inspecting color codes in the current line
vim.keymap.set("n", "<Leader>cs", function()
  editor.color.stop_inspect_line()
end)

-- inspect color codes in the lines
vim.keymap.set("v", "<Leader>cc", function()
  local s, e = vim.fn.line("v"), vim.fn.line(".")
  for i = s > e and e or s, s > e and s or e do
    editor.color.inspect_line(0, i)
  end
end)

-- stop inspecting color codes in the lines
vim.keymap.set("v", "<Leader>cs", function()
  local s, e = vim.fn.line("v"), vim.fn.line(".")
  for i = s > e and e or s, s > e and s or e do
    editor.color.stop_inspect_line(0, i)
  end
end)

-- Lazy manager
vim.keymap.set("n", "<Leader>lz", "<Cmd>Lazy<CR>")

-- half-page scroll
vim.keymap.set({ "n", "v" }, "<m-j>", "<c-d>")
vim.keymap.set({ "n", "v" }, "<m-k>", "<c-u>")

-- move to previous/next buffer
vim.keymap.set("n", "<c-p>", "<Cmd>bp<CR>")
vim.keymap.set("n", "<c-n>", "<Cmd>bn<CR>")

-- Windows Terminal
if vim.fn.has('win32') == 1 then
  vim.keymap.set("n", "<Leader>wt", function() -- new tab
    vim.cmd([[!wt -w 0 nt --title vim -d ]] .. vim.fn.expand('%:p:h'))
  end, { silent = true })

  vim.keymap.set("n", "<F7>", function() -- split
    vim.cmd([[!wt -w 0 sp -H --title vim -d ]] .. vim.fn.expand('%:p:h'))
  end, { silent = true })

  vim.keymap.set("n", "<Leader>gg", function() -- lazygit
    vim.cmd([[!wt -w 0 nt -p PowerShell -d ]] .. vim.fn.expand('%:p:h') .. [[ lazygit]])
  end, { silent = true })
end

-- exit term mode
vim.keymap.set("t", "<a-s-w>", "<c-\\><c-n>")

-- move between windows
vim.keymap.set("n", "sh", "<c-w>h")
vim.keymap.set("n", "sj", "<c-w>j")
vim.keymap.set("n", "sk", "<c-w>k")
vim.keymap.set("n", "sl", "<c-w>l")
vim.keymap.set("n", "sw", "<c-w>w")

-- resize window
vim.keymap.set("n", "<c-left>", "<c-w><")
vim.keymap.set("n", "<c-right>", "<c-w>>")
vim.keymap.set("n", "<c-up>", "<c-w>+")
vim.keymap.set("n", "<c-down>", "<c-w>-")
