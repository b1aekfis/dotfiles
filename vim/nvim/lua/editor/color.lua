local M = {}
local color = require 'util.color'

local inspect_ns = vim.api.nvim_create_namespace("editor_color_codes_inspect")

---@class Inspect
---@field bufnr? integer The buffer number, or if 0|nil, uses the current buffer.
---@field code string The color code string (HEX, RGB, HSL).
---@field lnum? integer The line number of the color code, if nil, uses the current line (under cursor) when bufnr is 0|nil (current buffer), otherwise defaults to line 1
---@field col integer The column index where the color code starts.
---@field len integer The length of the color code.

---Inspect a color code in the buffer.
---Available: HEX (#rrggbb | #rgb), RGB, HSL.
---@param opts Inspect
function M.inspect(opts)
  if not color.is_color_code(opts.code) then return end

  local r, g, b = opts.code:match("^rgb%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*%)$")
  local h, s, l = opts.code:match("^hsl%(%s*(%d+)%s*,%s*(%d+)%%%s*,%s*(%d+)%%%s*%)$")

  local hexcolor

  if r and g and b then
    r = tonumber(r) ---@cast r number
    g = tonumber(g) ---@cast g number
    b = tonumber(b) ---@cast b number
    if r <= 255 and r >= 0 and g <= 255 and g >= 0 and b <= 255 and b >= 0 then
      hexcolor = color.rgb_to_hex(r, g, b)
    else
      return
    end
  elseif h and s and l then
    h = tonumber(h) ---@cast h number
    s = tonumber(s) ---@cast s number
    l = tonumber(l) ---@cast l number
    if h <= 360 and h >= 0 and s <= 100 and s >= 0 and l <= 100 and l >= 0 then
      hexcolor = color.hsl_to_hex(h, s, l)
    else
      return
    end
  else
    hexcolor = opts.code
  end

  hexcolor = color.expand_hexcolor(hexcolor)
  local fg = color.relative_luminance(hexcolor) > 0.179 and '#000000' or '#ffffff'
  local group = "color_inspect_" .. hexcolor:sub(2):lower()
  if vim.fn.hlID(group) == 0 then
    vim.api.nvim_set_hl(0, group, { fg = fg, bg = hexcolor })
  end

  opts.bufnr = opts.bufnr or 0
  opts.lnum = opts.lnum or ((opts.bufnr == 0) and vim.api.nvim_win_get_cursor(0)[1]) or 1

  vim.api.nvim_buf_add_highlight(opts.bufnr, inspect_ns, group, opts.lnum - 1, opts.col - 1, opts.col - 1 + opts.len)
end

---Inspect color codes on the line.
---Available: HEX (#rrggbb | #rgb), RGB, HSL.
---@param bufnr integer|nil The buffer number, or if 0|nil, uses the current buffer
---@param lnum integer|nil The line number, if nil, uses the current line (under cursor) when bufnr is 0|nil (current buffer), otherwise defaults to line 1
function M.inspect_line(bufnr, lnum)
  bufnr = bufnr or 0
  lnum = lnum or ((bufnr == 0) and vim.api.nvim_win_get_cursor(0)[1]) or 1
  local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1]
  local patterns = {
    "#%x%x%x%x?%x?%x?",
    "rgb%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*%)",
    "hsl%(%s*%d+%s*,%s*%d+%%%s*,%s*%d+%%%s*%)"
  }

  vim.api.nvim_buf_clear_namespace(bufnr, inspect_ns, lnum - 1, lnum)

  for _, pat in ipairs(patterns) do
    for s, m in line:gmatch("()(" .. pat .. ")") do
      M.inspect({ code = m, lnum = lnum, col = s, len = #m })
    end
  end
end

---Stop inspecting color codes on the line.
---@param bufnr integer|nil The buffer number, or if 0|nil, uses the current buffer
---@param lnum integer|nil The line number, if nil, uses the current line (under cursor) when bufnr is 0|nil (current buffer), otherwise defaults to line 1
function M.stop_inspect_line(bufnr, lnum)
  bufnr = bufnr or 0
  lnum = lnum or ((bufnr == 0) and vim.api.nvim_win_get_cursor(0)[1]) or 1
  vim.api.nvim_buf_clear_namespace(bufnr, inspect_ns, lnum - 1, lnum)
end

---Inspect the color codes linearly in the buffer.
---Available: HEX (#rrggbb | #rgb), RGB, HSL.
---@param bufnr integer|nil The buffer number, or if 0|nil, uses the current buffer
function M.linear_inspect(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr or 0, inspect_ns, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr or 0, 0, -1, false)

  for lnum, line in ipairs(lines) do
    for col, m in line:gmatch("()(#%x%x%x%x?%x?%x?)") do
      local len = #m
      if len == 4 or len == 7 then -- #rgb or #rrggbb
        M.inspect({
          bufnr = bufnr,
          code = m,
          lnum = lnum,
          col = col,
          len = len
        })
      end
    end

    for col, m in line:gmatch("()(hsl%(%s*%d+%s*,%s*%d+%%%s*,%s*%d+%%%s*%))") do
      M.inspect({
        bufnr = bufnr,
        code = m,
        lnum = lnum,
        col = col,
        len = #m
      })
    end

    for col, m in line:gmatch("()(rgb%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*%))") do
      M.inspect({
        bufnr = bufnr,
        code = m,
        lnum = lnum,
        col = col,
        len = #m
      })
    end
  end
end

---Stop inspecting color codes in the buffer.
---@param bufnr integer|nil The buffer number, or if 0|nil, uses the current buffer
function M.stop_linear_inspect(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr or 0, inspect_ns, 0, -1)
end

return M
