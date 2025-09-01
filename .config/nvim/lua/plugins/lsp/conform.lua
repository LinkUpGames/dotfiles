return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  dependencies = { "mason-org/mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "[C]ode [F]ormat Injected Langs",
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local disable_filetypes = {} -- TODO: make this an option for all other formatters

      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 3000,
          lsp_format = "fallback",
        }
      end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
    },
  },
}
