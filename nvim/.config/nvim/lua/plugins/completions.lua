return {
  {
    --TODO theme this
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
          "onsails/lspkind.nvim",
        },
      },
      {
        "hrsh7th/cmp-nvim-lsp",
      },
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()
      local lspkind = require("lspkind")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.exact, -- 1. Prioritize exact string matches
            cmp.config.compare.locality, -- 2. Prioritize suggestions from the current file or local scope
            cmp.config.compare.kind,  -- 3. Prioritize by the kind of completion (e.g., methods before fields)
            cmp.config.compare.sort_text, -- 4. Use the sortText provided by the LSP (if available)
            cmp.config.compare.score, -- 5. Use the relevance score provided by the LSP (if available)
            cmp.config.compare.length, -- 6. Shorter suggestions are ranked higher
            cmp.config.compare.order, -- 7. The original order as a last resort          }
          },
        },
        window = {
          completion = cmp.config.window.bordered({ maxwidth = 50 }),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 30,                -- leading text (labelDetails)
              abbr = 50,                -- actual suggestion item
              show_labelDetails = true, -- Crucial: This tells lspkind to display label details, which include parameters
              ellipsis_char = "..."
            },
            -- symbol_map = { Copilot = "" },
            -- ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            -- show_labelDetails = true, -- show labelDetails in menu. Disabled by default
          }),
          -- format = function(_, vim_item)
          -- 	vim_item.menu = ""
          -- 	-- vim_item.kind = ""
          -- 	return vim_item
          -- end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp",               group_index = 1 },
          { name = 'nvim_lsp_signature_help' },
          { name = "luasnip",                group_index = 2 },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
