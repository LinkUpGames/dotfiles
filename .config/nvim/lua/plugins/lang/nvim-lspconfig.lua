return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.inlay_hints.enabled = true

    -- NOTE: This is to support virtual lines
    if vim.fn.has("nvim1.11") == 1 then
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
    end

    return opts
  end,
}
