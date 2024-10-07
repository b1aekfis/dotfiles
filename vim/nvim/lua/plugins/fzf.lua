return {
  "ibhagwan/fzf-lua",
  event = { "CmdlineEnter" },
  dependencies = { "nvim-tree/nvim-web-devicons", },
  opts = {
    defaults = {
      formatter = 'path.filename_first',
    },
    files = {
      file_icons = false,
    },
    winopts = {
      preview = {
        hidden = true,
      },
    },
  },
}
