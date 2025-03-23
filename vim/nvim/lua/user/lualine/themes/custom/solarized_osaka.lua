-- Copyright (c) 2025 b1aekfis
-- Custom lualine theme based on solarized-osaka color palette
-- Original solarized-osaka: https://github.com/craftzdog/solarized-osaka.nvim
-- License: MIT
-- stylua: ignore start
local colors = {
  blackest   = '#000000',
  base03     = '#002b36',
  base0      = '#9eacad',
  greyz      = '#56635f',
  yellow500  = "#b58900",
  magenta700 = "#b02669",
  blue700    = "#1b6497",
  cyan500    = '#2aa198',
  green500   = '#859900',
}

local mode_bg_colors = {
  normal   = colors.blue700,
  insert   = colors.green500,
  visual   = colors.magenta700,
  replace  = colors.yellow500,
  command  = colors.cyan500,
  terminal = colors.cyan500,
}
-- stylua: ignore end

local theme = {}
for mode, bg in pairs(mode_bg_colors) do
  theme[mode] = {
    a = { bg = bg, fg = colors.blackest },
    b = {
      bg = mode == 'normal' and colors.greyz or colors.blackest,
      fg = mode == 'normal' and colors.blackest or bg
    },
    c = { bg = colors.base03, fg = colors.base0 }
  }
end

theme.inactive = {
  a = { bg = colors.base03, fg = colors.base0 },
  b = { bg = colors.base03, fg = colors.base0 },
  c = { bg = colors.base03, fg = colors.base0 },
}

return theme
