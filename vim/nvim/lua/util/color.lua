local M = {}

local helpers = require 'incline.helpers'

---Get color from a highlight group.
---@param group string highlight group name
---@param prop string is 'fg'|'bg'|'sp'
---@return string|nil -- hex color in the format '#rrggbb' (lowercase) or nil
function M.hlcolor(group, prop)
  local color = vim.api.nvim_get_hl(0, { name = group, link = false })[prop]
  return (type(color)) == 'number' and string.format('#%06x', color) or nil
end

---Calculate perceived brightness (HSP model).
---@param hexcolor string hex color in the format '#rrggbb'
---@return number -- a value in the range 0 to 1
function M.perceived_brightness(hexcolor)
  local rgb = helpers.hex_to_rgb(hexcolor)
  return math.sqrt(0.299 * rgb.r ^ 2 + 0.587 * rgb.g ^ 2 + 0.114 * rgb.b ^ 2)
end

---Calculate the fake brightness score based on HSP and (sRGB / WCAG / ITU-R BT.709) models.
---@param hexcolor string hex color in the format '#rrggbb'
---@return number score a value in the range 0 to 1
function M.fake_brightness_score(hexcolor)
  local r = helpers.relative_luminance(hexcolor)
  local p = M.perceived_brightness(hexcolor)
  local score = math.abs(p - r)
  return score
end

---Calculate the fake brightness score based on HSP and (sRGB / WCAG / ITU-R BT.709) models.
---Picks the color with the least or most fake brightness score.
---@param mode string optional: 'min'|'max', default: 'min'
---@param colors string[] array of hex colors in the format '#rrggbb'
---@return string|nil -- hex color in the format '#rrggbb' or nil if array is nil
function M.extremum_fake_brightness_score(mode, colors)
  if type(mode) == 'table' then
    colors = mode
    mode = 'min'
  end

  local invert = (mode == 'max')
  local m_score, e_fake = math.huge, nil

  for _, c in ipairs(colors) do
    local score = M.fake_brightness_score(c)

    if invert then score = -score end
    if (score < m_score) then
      e_fake = c
      m_score = score
    end
  end
  return e_fake
end

return M
