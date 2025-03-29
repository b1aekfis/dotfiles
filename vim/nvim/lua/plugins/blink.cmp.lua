return {
  'saghen/blink.cmp',
  event = { 'InsertEnter' },
  version = "1.*",
  opts = {
    appearance = {
      nerd_font_variant = 'normal',
    },
    keymap = {
      ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
    sources = {
      providers = {
        buffer = {
          min_keyword_length = 3,
        },
        path = {
          opts = {
            show_hidden_files_by_default = true,
          },
        },
      },
    },
    cmdline = { enabled = false, },
    completion = {
      ghost_text = {
        enabled = true,
      },
      menu = {
        draw = {
          components = {
            kind = {
              width = { fill = false, },
              text = function(ctx)
                return '[' .. ctx.kind .. ']'
              end,
            },
          },
          columns = {
            { 'label', 'label_description', gap = 1 }, { 'kind' },
          },
        },
        max_height = 7,
        winblend = vim.o.pumblend,
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        auto_show = true,
        window = {
          winblend = vim.o.pumblend,
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu",
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        winblend = vim.o.pumblend,
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      },
    },
  }
}
