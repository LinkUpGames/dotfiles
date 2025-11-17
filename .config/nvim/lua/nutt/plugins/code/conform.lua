return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = "ConformInfo",
  ---@type conform.setupOpts | {ignore_filetypes: table<string>}
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
    },
    format_after_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
      async = true,
    },
  },
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({
          formatters = { "injected" },
          timeout_ms = 3000,
          async = true,
          lsp_format = "fallback",
        })
      end,
      desc = "[F]ormat Buffer",
    },
  },
  opts_extend = { "ignore_filetypes" },
}
