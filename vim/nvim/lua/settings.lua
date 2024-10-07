local global = vim.g
local o = vim.o

-- Map <leader>

global.mapleader = " "
global.maplocalleader = " "

-- Editor opts

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
