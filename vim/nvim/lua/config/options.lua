local o = vim.opt

vim.g.mapleader = " "
vim.g.terminal_emulator = "powershell"

o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.shadafile = "NONE"

o.number = true

o.syntax = "on"
o.autoindent = true
o.cursorline = true
o.tabstop = 4
o.shiftwidth = 4
o.wildmenu = true
o.showmatch = true
o.clipboard="unnamedplus"
o.expandtab = true
o.smarttab = true
o.termguicolors = true

o.fillchars = {
    vert = " ",
}

o.autochdir = true

-- for toggleterm
local powershell_options = {
  shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
  shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
  shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
  shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
  shellquote = "",
  shellxquote = "",
}

for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end
