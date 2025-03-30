return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.inlay_hints.enabled = true

    -- NOTE: This is to support virtual lines
    if vim.fn.has("nvim-0.11") == 1 then
      opts.diagnostics.virtual_lines = {
        current_line = false,
        prefix = "●",
      }

      opts.diagnostics.virtual_text = {
        current_line = true,
      }
    else
      opts.diagnostics.virtual_text = true
    end
  end,
}
