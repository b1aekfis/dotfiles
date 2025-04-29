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

---@param hexcolor string is '#rgb'|'#rrggbb'
---@return string hexcolor is '#rrggbb'
function M.expand_hexcolor(hexcolor)
  if #hexcolor == 4 then
    hexcolor = '#' .. table.concat({
      hexcolor:sub(2, 2):rep(2),
      hexcolor:sub(3, 3):rep(2),
      hexcolor:sub(4, 4):rep(2)
    })
  end
  return hexcolor
end

---@param h number Hue in degrees (0–360)
---@param s number Saturation as a percentage (0–100)
---@param l number Lightness as a percentage (0–100)
---@return string -- is '#rrggbb' (lowercase)
function M.hsl_to_hex(h, s, l)
  s = s / 100
  l = l / 100

  local function hue_to_rgb(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1 / 6 then return p + (q - p) * 6 * t end
    if t < 1 / 2 then return q end
    if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
    return p
  end

  local r, g, b
  if s == 0 then
    r, g, b = l, l, l
  else
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue_to_rgb(p, q, h / 360 + 1 / 3)
    g = hue_to_rgb(p, q, h / 360)
    b = hue_to_rgb(p, q, h / 360 - 1 / 3)
  end

  return string.format("#%02x%02x%02x",
    math.floor(r * 255),
    math.floor(g * 255),
    math.floor(b * 255))
end

---@param r number Red component (0–255)
---@param g number Green component (0–255)
---@param b number Blue component (0–255)
---@return string -- is '#rrggbb' (lowercase)
function M.rgb_to_hex(r, g, b)
  r = math.min(255, math.max(0, r))
  g = math.min(255, math.max(0, g))
  b = math.min(255, math.max(0, b))
  return string.format("#%02x%02x%02x", r, g, b)
end

---Check if the string is a valid color code (HEX, RGB, HSL).
---@param str string
---@return boolean
function M.is_color_code(str)
  if
    str:match("^#%x%x%x%x%x%x$")
    or str:match("^#%x%x%x$")
    or str:match("^rgb%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*%)$")
    or str:match("^hsl%(%s*%d+%s*,%s*%d+%%%s*,%s*%d+%%%s*%)$")
    then return true
  end
  return false
end

return M
