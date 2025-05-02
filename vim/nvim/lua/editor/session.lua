local M = {}

function M.prompt()
  local homedir = vim.uv.os_homedir():gsub("\\", "/")
  local state_home = os.getenv("XDG_STATE_HOME")
  state_home = state_home and state_home:gsub("\\", "/") or (homedir .. "/.local/state")
  local default_path = state_home .. "/nvim/sessions/"
  local input_path = vim.fn.input("Press 󱊷  to use default sessions path (" ..
  default_path:gsub("^" .. homedir, "~") .. ")\nor   ", "~/", "dir")
  input_path = input_path ~= "" and input_path:gsub("\\", "/") or input_path
  local path = input_path ~= "" and input_path:gsub("/$", "") .. "/" or default_path
  local cmd = vim.fn.input("'s' to source session, 'S' to save session: ", "s")
  if cmd ~= 's' and cmd ~= 'S' then return end
  cmd = cmd == 's' and "source" or "mkse!"
  vim.api.nvim_input(":" .. cmd .. " " .. (path:gsub("^" .. homedir, "~")))
end

return M
