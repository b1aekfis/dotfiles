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
