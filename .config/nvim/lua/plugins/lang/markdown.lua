return {
  {
    "stevearc/conform.nvim",
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        markdown = { "markdownlint" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        textlsp = {
          filetypes = { "markdown", "tex" },
        },
        marksman = {},
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = true,
    ft = { "markdown", "codecompanion" },
    opts = {
      filetypes = { "markdown", "codecompanion" },
      buf_ignore = {},
      preview = {
        icon_provider = "mini",
      },
    },
  },
}
