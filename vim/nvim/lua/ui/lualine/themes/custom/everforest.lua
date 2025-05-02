-- Based on everforest color palette by sainnhe
-- MIT license applies
-- stylua: ignore
local colors = {
  black  = '#000000',
  red    = '#e67e80',
  orange = '#e69875',
  green  = '#a7c080',
  blue   = '#7fbbb3',
  aqua   = '#83c092',
  fg     = '#d3c6aa',
  grey1  = '#859289',
  bg5    = '#56635f',
  bg3    = '#414b50',
  bg1    = '#2e383c',
}

return {
  normal = {
    a = { bg = colors.green, fg = colors.black },
    b = { bg = colors.bg5, fg = colors.black },
    c = { bg = colors.bg1, fg = colors.fg },
  },
  insert = {
    a = { bg = colors.blue, fg = colors.black },
    b = { bg = colors.bg3, fg = colors.fg },
    c = { bg = colors.bg1, fg = colors.fg },
  },
  visual = {
    a = { bg = colors.red, fg = colors.black },
    b = { bg = colors.bg3, fg = colors.fg },
    c = { bg = colors.bg1, fg = colors.fg },
  },
  replace = {
    a = { bg = colors.orange, fg = colors.black },
    b = { bg = colors.bg3, fg = colors.fg },
    c = { bg = colors.bg1, fg = colors.fg },
  },
  command = {
    a = { bg = colors.aqua, fg = colors.black },
    b = { bg = colors.bg3, fg = colors.fg },
    c = { bg = colors.bg1, fg = colors.fg },
  },
  terminal = {
    a = { bg = colors.blue, fg = colors.black },
    b = { bg = colors.bg3, fg = colors.fg },
    c = { bg = colors.bg1, fg = colors.fg },
  },
  inactive = {
    a = { bg = colors.bg1, fg = colors.grey1 },
    b = { bg = colors.bg1, fg = colors.grey1 },
    c = { bg = colors.bg1, fg = colors.grey1 },
  },
}
