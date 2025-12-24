local util = {}
util.color = require 'util.color'

-- Default bufferline options
local default_bufline_opts = {
  sep = '',
  sec_sep = '',
  mod_ind = '[M]',
  hl = 'TabLine',
  hl_sel = 'TabLineSel',
  hl_fill = 'TabLineFill',
}

-- User bufferline options
local bufline_opts = nil

-- Build bufferline
---@return string
local function bufline()
  local opts = bufline_opts or default_bufline_opts

  local sep = opts.sep
  local sec_sep = opts.sec_sep
  local mod_ind = opts.mod_ind
  local hl = opts.hl
  local hl_sel = opts.hl_sel
  local hl_fill = opts.hl_fill

  if type(hl) == 'string' then
    hl = vim.fn.hlexists(hl) == 1 and hl or default_bufline_opts.hl
  elseif type(hl) == 'table' then
    vim.api.nvim_set_hl(0, 'BufLine', hl)
    hl = 'BufLine'
  end

  if type(hl_sel) == 'string' then
    hl_sel = vim.fn.hlexists(hl_sel) == 1 and hl_sel or default_bufline_opts.hl_sel
  elseif type(hl_sel) == 'table' then
    vim.api.nvim_set_hl(0, 'BufLineSel', hl_sel)
    hl_sel = 'BufLineSel'
  end

  if type(hl_fill) == 'string' then
    hl_fill = vim.fn.hlexists(hl_fill) == 1 and hl_fill or default_bufline_opts.hl_fill
  elseif type(hl_fill) == 'table' then
    vim.api.nvim_set_hl(0, 'BufLineFill', hl_fill)
    hl_fill = 'BufLineFill'
  end

  --[[----------------------------------
  Tabline option automatically truncates
  the beginning of the input string when
  its width exceeds the window width.

  The focused buffer item should always
  stay in a non-truncated scope. That
  should be the minimum requirement.

  Simplest way to meet minimal
  requirement based on
  automatic-truncation mechanism is to
  always return a string that begins or
  ends at the focused item whenever
  input string is detected to exceed
  window width. But, this approach
  limits how intuitive it feels to
  navigate focus. So, still based on the
  automatic-truncation mechanism, a
  better way is to always return a
  string that spans outward from the
  position of the focused item in both
  directions in the buffer list whenever
  input string is detected to exceed
  window width.

  --[[----------------------------------
  Input string consists of three main
  sections:
  left | focused | right
  with two cases:
  basic case and planning case.

  In the planning case:

  left_width + focused_width +
  right_width > nvim_win_width

  Then:
  focused_width + right_width >
  nvim_win_width - left_width

  this is true for any width of the left
  section

  =>
  focused_width + right_width >
  nvim_win_width - planned_left_width

  <=>
  focused_width + right_width >
  expected_right_width
  ---------------------------------]]---

  local current_buf = vim.api.nvim_get_current_buf()
  local bufls = vim.api.nvim_list_bufs()

  local left = ""
  local right = ""
  local focused = ""
  local finished_left = false

  -- a section always starts and ends with one space
  for _, buf_id in ipairs(bufls) do
    if vim.bo[buf_id].buflisted then
      local buf_name = vim.api.nvim_buf_get_name(buf_id)
      buf_name = vim.fn.fnamemodify(buf_name, ":t")
      if buf_name == "" then buf_name = "[No Name]" end
      local label_text = " " .. buf_name .. " " .. (vim.bo[buf_id].modified and mod_ind .. " " or "")

      if finished_left then
        right = right .. (right ~= "" and sep or "") .. label_text
      else
        if buf_id == current_buf then
          focused = label_text
          finished_left = true
        else
          left = left .. (left ~= "" and sep or "") .. label_text
        end
      end
    end
  end

  local nvim_win_width = vim.o.columns
  local left_width = vim.fn.strdisplaywidth(left)
  local focused_width = vim.fn.strdisplaywidth(focused)
  local right_width = vim.fn.strdisplaywidth(right)

  -- sec_sep labels
  local ss_width = vim.fn.strdisplaywidth(sec_sep)

  local unfocused_bg = util.color.hlcolor(hl, 'bg')
  local focused_bg = util.color.hlcolor(hl_sel, 'bg')
  local fill_bg = util.color.hlcolor(hl_fill, 'bg')
  vim.api.nvim_set_hl(0, 'bufline_left_-_focused_ss', { fg = unfocused_bg, bg = focused_bg })
  vim.api.nvim_set_hl(0, 'bufline_focused_-_right_ss', { fg = focused_bg, bg = unfocused_bg })
  vim.api.nvim_set_hl(0, 'bufline_right_-_empty_ss', { fg = unfocused_bg, bg = fill_bg })
  vim.api.nvim_set_hl(0, 'bufline_focused_-_empty_ss', { fg = focused_bg, bg = fill_bg })
  local left_ss_label, focused_ss_label, right_ss_label = "","",""

  if left_width ~= 0 then
    left_width = left_width + ss_width
    if focused_width ~= 0 then
      left_ss_label = "%#bufline_left_-_focused_ss#" .. sec_sep
    else
      left_ss_label = "%#bufline_right_-_empty_ss#" .. sec_sep
    end
  end

  if focused_width ~= 0 then
    focused_width = focused_width + ss_width
    if right_width ~= 0 then
      focused_ss_label = "%#bufline_focused_-_right_ss#" .. sec_sep
    else
      focused_ss_label = "%#bufline_focused_-_empty_ss#" .. sec_sep
    end
  end

  if right_width ~= 0 then
    right_width = right_width + ss_width
    right_ss_label = "%#bufline_right_-_empty_ss#" .. sec_sep
  end

  -- The basic case
  if (left_width + focused_width + right_width) <= nvim_win_width then
    return "%#" .. hl .. "#" .. left
    .. left_ss_label
    .. "%#" .. hl_sel .. "#" .. focused
    .. focused_ss_label
    .. "%#" .. hl .. "#" .. right
    .. right_ss_label
    .. "%#" .. hl_fill .. "#"
  end

  -- The planning case
  local planned_left_width = math.floor((nvim_win_width - focused_width)/2)

  if left_width > planned_left_width then
    left_width = planned_left_width
  end

  local expected_right_width = nvim_win_width - left_width - focused_width

  local right_length = vim.fn.strchars(right)
  local tbl = {}

  for i = 0, right_length - 1 do
    tbl[#tbl+1] = vim.fn.strcharpart(right, i, 1)
    local get_right = table.concat(tbl)
    if vim.fn.strdisplaywidth(get_right) >= expected_right_width - ss_width then
      local right_arrow = ">" -- 1 cell
      right = vim.fn.strcharpart(get_right, 0, vim.fn.strchars(get_right) - 1)
      local n_space = (expected_right_width - ss_width) - vim.fn.strdisplaywidth(right) - 1 -- 1 = vim.fn.strdisplaywidth(right_arrow)
      local spaces = string.rep(" ", n_space)
      right = right .. spaces .. right_arrow

      -- debug
      -- print(vim.fn.strdisplaywidth(right .. sec_sep) .. "|" .. (expected_right_width))

      break
    end
  end

  return "%#" .. hl .. "#" .. left
  .. left_ss_label
  .. "%#" .. hl_sel .. "#" .. focused
  .. focused_ss_label
  .. "%#" .. hl .. "#" .. right
  .. right_ss_label
  .. "%#" .. hl_fill .. "#"
end

---@private
function _G._nvim_lua_ui_tabline_bufline_entry_point()
  return bufline()
end

local M = {}

---@class BufLineOpts
---@field sep? string Separator between buffer labels (default: '')
---@field sec_sep? string Separator between buffer-label sections (default: '')
---@field mod_ind? string Indicator when buffer is modified (default: '[M]')
---@field hl? string|table Highlight group name or highlight spec for buffer labels (default: 'TabLine')
---@field hl_sel? string|table Highlight group name or highlight spec for focused buffer label (default: 'TabLineSel')
---@field hl_fill? string|table Highlight group name or highlight spec for remaining line area (default: 'TabLineFill')

--- Setup bufferline as the tabline.
---@param opts? BufLineOpts Options table
function M.setup_bufline(opts)
  bufline_opts = vim.tbl_deep_extend('force', default_bufline_opts, opts or {})
  vim.o.tabline = "%!v:lua._nvim_lua_ui_tabline_bufline_entry_point()"
  vim.o.showtabline = 2
end

return M
