return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.inlay_hints.enabled = true

    opts.diagnostics.virtual_lines = {
      current_line = false,
      prefix = "●",
      severity = {
        min = vim.diagnostic.severity.ERROR,
      },
    }

    opts.diagnostics.virtual_text.severity = {
      max = vim.diagnostic.severity.WARN,
    }

    return opts
  end,
}
