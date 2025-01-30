return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
  opts = {
    -- routes
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true, },
      },
      {
        -- LOG: tracking...
        filter = {
          event = "msg_show",
          kind = {
            "emsg",
            "wmsg",
            "lua_error"
          },
          min_width = 80
        },
        view = "messages",
      },
      {
        filter = {
          event = "msg_showmode",
        },
        view = "notify",
      },
      {
        filter = {
          event = "msg_show",
          cmdline = "ls",
        },
        view = "split",
      },
    },
    -- ConfigViews
    views = {
      split = {
        size = "21%",
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
      },
      popup = {
        size = "auto",
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
      },
      mini = {
        border = { style = "rounded", },
        win_options = {
          winhighlight = "Normal:NoiceCmdlineIconLua,FloatBorder:NoiceCmdlineIconLua",
          winblend = 0,
        },
        position = { row = 3, col = "88%" },
        timeout = 1000,
      },
    },
    -- presets
    presets = {
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    -- mes
    messages = {
      enabled = true,
    },
    -- popupmenu
    popupmenu = { enabled = false, },
    -- lsp
    lsp = {
      progress = { enabled = false, },
      signature = { enabled = false, },
    },
  },
}
