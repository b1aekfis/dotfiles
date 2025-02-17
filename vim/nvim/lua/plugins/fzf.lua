return {
  "ibhagwan/fzf-lua",
  event = { "CmdlineEnter" },
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

    return {
      defaults = {
        formatter = 'path.filename_first',
        file_icons = false,
      },
      fzf_colors = {
        ["pointer"] = "#d7005f",
        ["spinner"] = "#af5fff",
        ["info"] = "#afaf87",
        ["marker"] = "#e67e80",
        ["prompt"] = "#5f87af",
        ["gutter"] = "-1",
      },
      fzf_opts = {
        ["--pointer"] = ">",
        ["--info"] = false,
        ["--style"] = "minimal",
      },
      files = {
        hls = {
          border = "FloatBorder",
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
    }
  end
}
