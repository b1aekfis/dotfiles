vim.g.mapleader = '\\'
vim.g.maplocalleader = ' '

vim.g.netrw_altv = 1

vim.opt.shadafile = 'NONE'
vim.opt.swapfile = false
vim.opt.autochdir = true

-- editing
vim.opt.clipboard = 'unnamedplus'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.breakindent = true

-- ui
vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.guicursor = "n-v-sm:block,c-i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.pumblend = 28
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wildoptions = 'tagfile'
vim.opt.title = true
vim.opt.ruler = false
vim.opt.fillchars = { eob = ' ' }
