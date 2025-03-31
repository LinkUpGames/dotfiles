return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.inlay_hints.enabled = true

    -- NOTE: This is to support virtual lines
    if vim.fn.has("nvim-0.11") == 1 then
      opts.diagnostics.virtual_lines = {
        current_line = true,
        prefix = "●",
      }

      opts.diagnostics.virtual_text = false
    end
  end,
}
