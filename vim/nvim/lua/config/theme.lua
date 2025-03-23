local theme_file = vim.fn.stdpath("config") .. "/.nvim_theme"
local default_theme = "solarized_osaka"

local available_themes = {
  "solarized_osaka",
  "everforest",
}

local function is_valid_theme(theme)
  for _, v in ipairs(available_themes) do
    if v == theme then
      return true
    end
  end
  return false
end

do
  local theme = default_theme
  local f = io.open(theme_file, "r")
  if f then
    local read_theme = f:read("*l")
    if read_theme and read_theme ~= "" and is_valid_theme(read_theme) then
      theme = read_theme
    end
    f:close()
  else
    local fw = io.open(theme_file, "w")
    if fw then
      fw:write(default_theme)
      fw:close()
    end
  end
  _G.CURRENT_COLORSCHEME = theme
end

do
  vim.api.nvim_create_user_command('Theme', function(opts)
    local new_theme = opts.args

    if not is_valid_theme(new_theme) then
      vim.notify("Theme '" .. new_theme .. "' is not available!", vim.log.levels.ERROR)
      return
    end

    local f = io.open(theme_file, "w")
    if not f then
      vim.notify("Failed to write theme file!", vim.log.levels.ERROR)
      return
    end
    f:write(new_theme)
    f:close()

    local check = io.open(theme_file, "r")
    if check then
      check:close()
      print("Theme switched to " .. new_theme .. ", restart Neovim!")
    else
      print("Wrote theme, but cannot read back. Please check file permissions.")
    end
  end, {
    nargs = 1,
    complete = function(arg_lead)
      local matches = {}
      for _, theme in ipairs(available_themes) do
        if theme:find(arg_lead, 1, true) == 1 then
          table.insert(matches, theme)
        end
      end
      return matches
    end
  })
end
