return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local defaults = opts.sources.default or {}
      table.insert(defaults, "lazydev")

      local source = {
        sources = {
          default = defaults,
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100, -- show at a higher priority than lsp
            },
          },
        },
      }

      opts = vim.tbl_deep_extend("force", opts or {}, source)

      return opts
    end,
  },
}
