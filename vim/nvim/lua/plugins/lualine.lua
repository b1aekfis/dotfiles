-- LOG: #0
-- bug(Windows): Not detecting branch on moving (entering, switching-to) between buffers
-- lualine is unable to detect the current branch for incorrect separators
-- fix: see@../config/autocmds.lua
-- ----------
return {
  "nvim-lualine/lualine.nvim",
  event = "BufReadPre",
  opts = function()
    local theme = require 'lualine.themes.everforest'
    theme.terminal.a.bg = '#7fbbb3'
    theme.normal.a.gui = 'none'
    theme.insert.a.gui = 'none'
    theme.normal.b = {
      fg = '#000000',
      bg = '#56635f',
    }

    return {
      options = {
        component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        globalstatus = true,
        icons_enabled = false,
        always_show_tabline = false,
        theme = theme,
      },
      sections = {
        lualine_b = {
          "vim.b.br_lualine",
          -- parent/filename Mf
          {
            -- parent/filename
            "vim.fn.expand('%:p:h:t')..'/%f'",
            component_separators = "",
          },
          {
            -- Mf
            "vim.bo.modified and 'M' or ''",
            color = { fg = '#ff0000', },
            padding = {
              left = 0,
            },
          },
        },
        lualine_c = {
        },
        lualine_x = {
          {
            -- Hao
            "'好'",
            cond = function()
              local function diag_count(T)
                return #vim.diagnostic.get(0, {
                  severity = vim.diagnostic.severity[T]
                })
              end
              return (diag_count('ERROR') == 0
                    and diag_count('WARN') == 0
                    and diag_count('INFO') == 0
                    and diag_count('HINT') == 0)
                  and true or false
            end
            ,
            color = function()
              return {
                fg = vim.lsp.buf_is_attached(0) and "#7fffb3" or nil
              }
            end
          },
          {
            'diagnostics',
            symbols = {
              error = 'E',
              warn = 'W',
              info = 'I',
              hint = 'H'
            },
          },
          -- 'searchcount',
        },
        lualine_y = {
          "'['..'%l:%c'..']'",
          'progress',
        },
        lualine_z = {
          "os.date('%I:%M %p')",
        },
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            max_length = vim.o.columns,
            buffers_color = {
              active = 'lualine_a_terminal',
            },
          },
        },
      },
    }
  end
}
