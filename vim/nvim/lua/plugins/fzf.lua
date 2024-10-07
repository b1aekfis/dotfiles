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
      fd_opts = [[--color=never --type f --type l --hidden --exclude .git]],
    },
    winopts = {
      preview = {
        hidden = true,
      },
    },
  },
}
