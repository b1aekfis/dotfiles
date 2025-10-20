return {
  "ibhagwan/fzf-lua",
  keys = {
    {
      "<Leader>ff", "<Cmd>FzfLua files<CR>", silent = true
    },
    {
      "<Leader>gf", "<Cmd>FzfLua git_files<CR>", silent = true
    },
    {
      "<Leader>Ff", "<Cmd>FzfLua files cwd=~<CR>", silent = true -- user files
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons", },
  opts = function()

    local actions = require("fzf-lua").actions

    local colors = {
      pointer = "#648f90",
      spinner = "#648f90",
      info = "#afaf87", -- based on Fzf defaults: Dark256 Info (144)
      prompt = "#648f90",
      hl = "#859900"
    }

    vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { fg = colors.prompt })

    return {
      defaults = {
        formatter = 'path.filename_first',
        file_icons = false,
      },
      fzf_colors = {
        true,
        ["hl"] = colors.hl,
        ["hl+"] = colors.hl,
        ["bg+"] = "-1",
        ["pointer"] = colors.pointer,
        ["spinner"] = colors.spinner,
        ["info"] = colors.info,
        ["marker"] = colors.pointer,
        ["prompt"] = colors.prompt,
      },
      fzf_opts = {
        ["--info"] = false,
      },
      git = {
        files = {
          cmd = "git ls-files --exclude-standard --cached --others"
        },
      },
      actions = {
        files = {
          ["enter"] = actions.file_edit,
        },
      },
      winopts = {
        preview = {
          hidden = true,
          vertical = 'up:70%',
          scrollbar = false,
          winopts = {
            number = false,
          },
        },
        row = 0.5,
        height = 0.7,
      },
      hls = {
        border = "FloatBorder",
        preview_border = "FloatBorder"
      },
    }
  end
}
