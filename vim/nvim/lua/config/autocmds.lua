-- branch name (git)
local function get_branch_name()
  local str = vim.fn.trim(vim.fn.system("git -C " .. vim.fn.expand('%:p:h') .. " branch --show-current"))
  return (string.sub(str, 1, 7) ~= "fatal: ") and " " .. str or ""
end
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.*",
  callback = function() vim.b.branch = get_branch_name()
  end
})

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
