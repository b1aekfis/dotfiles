return {
  "echasnovski/mini.diff",
  version = false,
  event = "BufReadPre",
  keys = {
    {
      "<Leader>D", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", silent = true
    },
  },
  opts = {
    view = {
      signs = {
        add = ' ▎',
        change = ' ▎',
        delete = ' ▎',
      },
    },
    mappings = {
      apply = 'gA',
    },
  }
}
