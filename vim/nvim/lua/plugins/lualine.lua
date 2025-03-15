-- LOG: #0
-- bug(Windows) on branch component (opt): not detecting branch on moving (entering, switching-to) between buffers
-- it seems lualine is unable to detect the current branch for incorrect separators
-- ----------
return {
  "nvim-lualine/lualine.nvim",
  event = "BufReadPre",
  opts = function()
    local theme = require 'lualine.themes.everforest'
    theme.normal.a.gui = ''
    theme.insert.a.gui = ''
    theme.visual.a.gui = ''
    theme.replace.a.gui = ''
    theme.command.a.gui = ''
    theme.terminal.a.gui = ''
    theme.terminal.a.bg = '#7fbbb3'
    theme.normal.b.fg = '#000000'
    theme.normal.b.bg = '#56635f'

    local colors = {
      diagnoster = '#7fffb3'
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
          "vim.b.branch",
          -- parent/filename
          {
            -- parent/
            "vim.fn.expand('%:p:h:t')..'/'",
            component_separators = "",
            padding = {
              right = 0,
              left = 1,
            },
          },
          {
            -- filename
            "'%f'",
            color = function()
              return vim.bo.modified and (vim.fn.mode(0) ~= 'n'
                    and { fg = '#ff0000' } or { fg = '#8b0000' })
                  or nil
            end,
            padding = {
              left = 0,
              right = 1,
            },
          },
        },
        lualine_c = {}, -- layout
        lualine_x = {}, -- layout
        lualine_y = {
          -- diagnostics
          {
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
                fg = vim.lsp.buf_is_attached(0) and colors.diagnoster or nil
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
            diagnostics_color = {
              error = { fg = colors.diagnoster },
              warn = { fg = colors.diagnoster },
              info = { fg = colors.diagnoster },
              hint = { fg = colors.diagnoster },
            },
          },
          -- 'searchcount',
          "'['..'%l:%c'..']'",
          'progress',
          'fileformat',
        },
        lualine_z = {
          "os.date('%I:%M %p')",
        },
      },
      inactive_sections = {},
      tabline = {
        lualine_a = {
          {
            'buffers',
            max_length = vim.o.columns,
            buffers_color = {
              active = 'lualine_a_terminal',
              inactive = 'lualine_b_terminal',
            },
          },
        },
      },
    }
  end
}
