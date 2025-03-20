return {
  "b0o/incline.nvim",
  event = "BufReadPre",
  keys = {
    {
      "<Leader>I", function() require 'incline'.toggle() end, silent = true
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons", },
  opts = {
    window = {
      padding = 0,
      margin = { vertical = 2, horizontal = 1 },
    },
    hide = { cursorline = true },
    render = function(props)
      local devicons = require 'nvim-web-devicons'
      local helpers = require 'incline.helpers'
      local colorist = require 'util.color'

      -- ft_icon + filename
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
      if filename == '' then
        filename = '[No Name]'
      end
      local ft_icon = devicons.get_icon_color(filename)
      local modified = vim.bo[props.buf].modified

      -- diff summary
      local smr = vim.b.minidiff_summary
      local add_smr = smr and smr.add and smr.add > 0 and '  ' .. smr.add or ''
      local del_smr = smr and smr.delete and smr.delete > 0 and '  ' .. smr.delete or ''
      local chg_smr = smr and smr.change and smr.change > 0 and '  ' .. smr.change or ''

      local hlcolor = colorist.hlcolor
      local add_fg = hlcolor('MiniDiffSignAdd', 'fg') or hlcolor('Added', 'fg') or hlcolor('diffAdded', 'fg')
      local chg_fg = hlcolor('MiniDiffSignChange', 'fg') or hlcolor('Changed', 'fg') or hlcolor('diffChanged', 'fg')
      local del_fg = hlcolor('MiniDiffSignDelete', 'fg') or hlcolor('Removed', 'fg') or hlcolor('diffRemoved', 'fg')

      --[[
      Colors in the same color scheme usually have no significant difference in relative luminance values. In that case, least_fake is useful when these values are close to the threshold and fall on both sides of it.
      ]]
      local least_fake = colorist.extremum_fake_brightness_score({ add_fg, chg_fg, del_fg })
      local smr_bg = helpers.contrast_color(least_fake) -- threshold = 0.179

      -- searchcount
      local scter = vim.fn.searchcount { maxcount = 999 }
      local searchcount = string.format('[%s/%s]', scter.current, scter.total)

      return {
        props.focused and {
          { add_smr, guifg = add_fg },
          { chg_smr, guifg = chg_fg },
          { del_smr, guifg = del_fg },
          add_smr == '' and chg_smr == '' and del_smr == '' and '' or ' ',
          guibg = smr_bg,
        } or '',

        ' ',
        ft_icon and { ft_icon, ' ' } or '',
        filename, modified and { ' ', '[M]' } or '',
        props.focused and
        (
          vim.v.hlsearch == 0 and '' or
          ((scter.total == 0 or scter.total == nil) and '' or { ' ', searchcount })
        )
        or '',
        ' ',
      }
    end,
  },
}
