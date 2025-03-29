-- g++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.keymap.set("n", "<F5>", "<Cmd>w<Bar>!g++ -I ./libs -std=c++20 -g -Wall *." .. vim.bo.filetype .. " -o main<CR>")
  end
})

-- opts
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.opt.showmode = false
  end
})
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end
})
