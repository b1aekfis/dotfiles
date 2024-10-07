return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    { "hrsh7th/cmp-buffer" },     -- source for text in buffer
    { "hrsh7th/cmp-path" },       -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",     -- vs-code like pictograms
  },
  opts = function()
    vim.cmd([[
        set completeopt=menuone,noinsert,noselect
        highlight! default link CmpItemKind CmpItemMenuDefault
        ]])

    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    return {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {

        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),

        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
          }),
        }),
      },
      window = {
        completion = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        },
      },
    }
  end,
}
