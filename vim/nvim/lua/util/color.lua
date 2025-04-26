local M = {}

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
  local rgb = M.hex_to_rgb(hexcolor)
  return math.sqrt(0.299 * rgb.r ^ 2 + 0.587 * rgb.g ^ 2 + 0.114 * rgb.b ^ 2)
end

---Calculate the fake brightness score based on the difference between HSP and WCAG luminance.
---@param hexcolor string hex color in the format '#rrggbb'
---@return number score a value in the range 0 to 1
function M.fake_brightness_score(hexcolor)
  local r = M.relative_luminance(hexcolor)
  local p = M.perceived_brightness(hexcolor)
  local score = math.abs(p - r)
  return score
end

---Picks the color with the least or most fake brightness score.
---The fake brightness score is based on the difference between HSP and WCAG luminance.
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

---@param hexcolor string is '#rrggbb'
---@return table -- RGB color table with fields r, g, b, each in the range 0 to 1
function M.hex_to_rgb(hexcolor)
  hexcolor = hexcolor:gsub("#", "")
  local r = tonumber(hexcolor:sub(1, 2), 16) / 255
  local g = tonumber(hexcolor:sub(3, 4), 16) / 255
  local b = tonumber(hexcolor:sub(5, 6), 16) / 255
  return { r = r, g = g, b = b }
end

---Calculate the relative luminance of a color (WCAG).
---@param input_color string|table is '#rrggbb' or RGB color table with fields r, g, b, each in the range 0 to 1
---@return number
function M.relative_luminance(input_color)
  local function srgb_to_linear(c)
    if c <= 0.03928 then
      return c / 12.92
    else
      return ((c + 0.055) / 1.055) ^ 2.4
    end
  end

  local rgb = type(input_color) == 'string' and M.hex_to_rgb(input_color) or input_color
  local r, g, b = srgb_to_linear(rgb.r), srgb_to_linear(rgb.g), srgb_to_linear(rgb.b)
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

return M
