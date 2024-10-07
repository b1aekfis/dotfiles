return {
  "folke/todo-comments.nvim",
  cmd = { "TodoLocList", "TodoQuickFix" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- NOTE: ripgrep and plenary.nvim are used for searching
    keywords = {
      ISSUES = {
        icon = " ",
        color = "#d699b6",
        alt = { "ISS" },
      },
      LOG = {
        icon = " ",
        color = "#d699b6",
      },
    },
  }
}
