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
        ltex = {
          filetypes = {
            "markdown",
            "text",
            "tex",
          },
          language = "en",
          additionalRules = {
            languageModel = "~/ngrams/",
          },
        },
        marksman = {},
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = true,
    ft = { "markdown" },
    opts = {
      preview = {
        filetypes = { "markdown", "md" },
        icon_provider = "mini",
      },
    },
  },
}
