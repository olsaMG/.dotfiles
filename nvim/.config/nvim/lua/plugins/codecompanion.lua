return { {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      -- Change the default chat adapter and model
      chat = {
        adapter = {
          name = "gemini",
          -- model = "gemini-2.5-pro",
          model = "gemini-2.5-flash",
        },
      },
    },
    -- NOTE: The log_level is in `opts.opts`
    -- opts = {
    --   log_level = "DEBUG",
  },
},
}
