-- This is something to add once fedora updates there package repo
---@module "lazy"
---@type LazySpec
return {
  "mcauley-penney/visual-whitespace.nvim",
  config = true,
  keys = { "v", "V", "<C-v>" }, -- optionally, lazy load on visual mode keys,
}
