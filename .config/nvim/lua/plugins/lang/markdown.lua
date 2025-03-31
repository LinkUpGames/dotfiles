return {
  -- Conform
  {
    "stevearc/conform.nvim",
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        markdown = { "markdownlint" },
      },
    },
  },
  -- Lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {
          filetypes = { "markdown", "text" },
          settings = {
            ["harper-ls"] = {
              userDictPath = "",
              fileDictPath = "",
              linters = {
                SpellCheck = true,
                SpelledNumbers = false,
                AnA = true,
                SentenceCapitalization = true,
                UnclosedQuotes = true,
                WrongQuotes = false,
                LongSentences = true,
                RepeatedWords = true,
                Spaces = true,
                Matcher = true,
                CorrectNumberSuffix = true,
              },
              codeActions = {
                ForceStable = false,
              },
              markdown = {
                IgnoreLinkTitle = false,
              },
              diagnosticSeverity = "hint",
              isolateEnglish = false,
            },
          },
        },
        marksman = {},
      },
    },
  },
  -- Blink
  {
    "Saghen/blink.cmp",
    opts = {
      sources = {
        per_filetype = {
          markdown = { "snippets", "path", "lsp" },
        },
      },
    },
  },
  -- Markview
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
