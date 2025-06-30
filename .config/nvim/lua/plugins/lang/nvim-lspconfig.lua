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

    -- Color of line
    opts.diagnostics.signs.numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    }

    return opts
  end,
}
