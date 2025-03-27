local M = {}

--- @param path string|function|nil The path to the directory where the Git repository is located. If it's a function, it will be called to get the path. If nil, the current buffer's directory will be used.
--- @return string branch_name -- The branch name or an empty string if not in a Git repository.
function M.get_branch_name(path)
  if type(path) == 'function' then
    path = path()
  end
  path = path and vim.fn.fnamemodify(path, ":p:h") or vim.fn.expand('%:p:h')
  local dev_null = vim.fn.has("win32") == 1 and "nul" or "/dev/null"
  local branch_name = vim.fn.trim(vim.fn.system("git -C " ..  vim.fn.fnameescape(path) .. " branch --show-current 2>" .. dev_null))
  return branch_name
end

return M
