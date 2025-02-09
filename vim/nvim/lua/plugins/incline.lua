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
      winhighlight = {
        active = {
          Normal = 'YzInclineNormal',
        },
        inactive = {
          Normal = 'YzInclineNormalNC',
        },
      },
      padding = 0,
      margin = { vertical = 2, horizontal = 1 },
    },
    hide = { cursorline = true },
    render = function(props)
      -- ft_icon + filename
      local devicons = require 'nvim-web-devicons'
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
      local mod_smr = smr and smr.change and smr.change > 0 and '  ' .. smr.change or ''

      -- searchcount
      local scter = vim.fn.searchcount { maxcount = 999 }
      local searchcount = string.format('[%s/%s]', scter.current, scter.total)

      return {
        props.focused and {
          { add_smr, guifg = '#a7c080', },
          { mod_smr, guifg = '#7fbbb3', },
          { del_smr, guifg = '#e67e80', },
          add_smr == '' and mod_smr == '' and del_smr == '' and '' or ' ',
          guibg = '#000000',
        } or '',

        ' ',
        ft_icon and { ft_icon, ' ' } or '',
        filename, modified and { ' ', '[M]' } or '',
        props.focused and
        (
        vim.v.hlsearch == 0 and '' or
        ((scter.total == 0 or scter.total == nil) and '' or { ' ', searchcount})
        )
        or '',
        ' ',
      }
    end,
  },
}
