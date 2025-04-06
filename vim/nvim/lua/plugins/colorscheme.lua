return {
  {
    "sainnhe/everforest",
    lazy = _G.CURRENT_COLORSCHEME ~= 'everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_spell_foreground = 'colored'
      vim.g.everforest_background = 'hard'
      vim.g.everforest_float_style = 'dim'
      vim.g.everforest_transparent_background = 2

      vim.cmd.colorscheme("everforest")
      vim.cmd([[hi Pmenu guibg=#00121a]])
      vim.cmd([[hi! link PmenuExtra Pmenu]])
      vim.cmd([[hi PmenuSel guibg=#000000 guifg=#f2f2f2]])
      vim.cmd([[hi NormalFloat guibg=#000000 blend=28]])
      vim.cmd([[hi FloatBorder guibg=none]])
      vim.cmd([[hi QuickFixLine guibg=none guifg=none]])
      vim.cmd([[hi InclineNormalNC guibg=#000000 guifg=#a7c080 gui=italic]])
      vim.cmd([[hi InclineNormal guibg=#a7c080 guifg=#1e2326]])
      vim.cmd([[hi link LazyNormal Normal]])
    end
  },

  {
    {
      "craftzdog/solarized-osaka.nvim",
      lazy = _G.CURRENT_COLORSCHEME ~= 'solarized_osaka',
      priority = 1000,
      opts = {
        on_highlights = function(hls, colors)
          hls.DiffAdd = { bg = colors.green900 }
          hls.DiffDelete = { bg = colors.red900 }
          hls.DiffText = { bg = colors.blue900, fg = colors.yellow }
          hls.DiffChange = { bg = colors.blue900 }
          hls.DiagnosticInfo = { fg = colors.cyan }
          hls.MiniDiffSignChange = { fg = colors.blue }
          hls.NormalFloat = { bg = '#000000', blend = 28 }
          hls.FloatBorder = { fg = colors.base01 }
          hls.Delimiter = { fg = colors.base01 }
          hls.Pmenu = { bg = '#00121a', fg = colors.base0 }
          hls.PmenuSel = { bg = '#f2f2f2', fg = '#000000' }
          hls.PmenuSbar = { bg = '#000000' }
          hls.PmenuThumb = { bg = colors.violet }
          hls.LineNr = { fg = colors.base01 }
          hls.StatusLine = { bg = colors.none }
          hls.QuickFixLine = {}
          hls.InclineNormalNC = { bg = '#000000', fg = colors.green, italic = true }
          hls.InclineNormal = { bg = colors.green, fg = '#1e2326' }
          hls.LazyNormal = { link='Normal' }

          local pats = {
            "FzfLua", "MiniIndentscope"
          }
          for k in pairs(hls) do
            for _, p in ipairs(pats) do
              if k:match("^" .. p) then hls[k] = nil end
            end
          end
        end,
      },
      config = function(_, opts)
        require('solarized-osaka').setup(opts)
        vim.cmd([[colorscheme solarized-osaka]])
      end
    }
  }
}
