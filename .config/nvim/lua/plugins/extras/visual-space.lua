-- This is something to add once fedora updates there package repo
return {
  "mcauley-penney/visual-whitespace.nvim",
  config = true,
  keys = { "v", "V", "<C-v>" }, -- optionally, lazy load on visual mode keys,
  enabled = function()
    if vim.fn.has("nvim-0.11") == 1 then
      return true
    end

    return false
  end,
}
