return {
  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = {
  --     linters_by_ft = {
  --       typescript = { "eslint_d" },
  --       javascript = { "eslint_d" },
  --       typescriptreact = { "eslint_d" },
  --       javascriptreact = { "eslint_d" },
  --     },
  --     ---@type table<string, table>
  --     linters = {
  --       eslint_d = {
  --         condition = function(ctx)
  --           return vim.fs.find({ ".eslintrc", "eslint.config.js" }, { path = ctx.filename, upward = true })[1]
  --         end,
  --       },
  --     },
  --   },
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "javascriptreact",
            "typescriptreact",
            "mdx",
            "postcss",
            "sass",
            "scss",
            "sugarss",
            "php",
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        typescript = { "prettier" },
        javascript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "LazyFile",
    opts = {},
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {
  --     --   settings = {
  --     --     tsserver_file_preferences = {
  --     --       includeInlayParameterNameHints = "all",
  --     --     },
  --     --   },
  --   },
  --   enabled = false,
  -- },
}
