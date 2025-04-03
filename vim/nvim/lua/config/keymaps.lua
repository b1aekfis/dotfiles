local opts = { noremap = true, silent = true }
local homedir = vim.uv.os_homedir():gsub("\\", "/")

-- session
local function input_sessions_path()
  local state_home = os.getenv("XDG_STATE_HOME")
  state_home = state_home and state_home:gsub("\\", "/") or (homedir .. "/.local/state")
  local default_path = state_home .. "/nvim/sessions/"
  local input_path = vim.fn.input("Press 󱊷  to use default sessions path (" ..
  default_path:gsub("^" .. homedir, "~") .. ")\nor   ", "~/", "dir")
  input_path = input_path ~= "" and input_path:gsub("\\", "/") or input_path
  return input_path ~= "" and input_path:gsub("/$", "") .. "/" or default_path
end

vim.keymap.set("n", "SS",
  function()
    local path = input_sessions_path()
    local cmd = vim.fn.input("'s' to source session, 'S' to save session", "s")
    if cmd ~= 's' and cmd ~= 'S' then return end
    cmd = cmd == 's' and "source" or "mkse!"
    vim.api.nvim_input(":" .. cmd .. " " .. (path:gsub("^" .. homedir, "~")))
  end)

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
