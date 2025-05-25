-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.background = "dark"

local old_guicursor = vim.o.guicursor

vim.g.mapleader = " "
vim.o.guicursor = old_guicursor .. ",n-v-c:block-blinkon700-blinkoff400,i-ci-ve:ver25-blinkon700-blinkoff400"

-- Setup The column
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

vim.o.cursorline = false

-- Lazy vim options
vim.g.lazyvim_picker = "snacks"

-- Copy/Paste
local paste = function()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {

    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["-"] = require("vim.ui.clipboard.osc52").copy("-"),
  },
  paste = {
    ["+"] = paste,
    ["-"] = paste,
  },
}

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono"

  vim.g.neovide_window_blurred = true
  vim.g.neovide_transparency = 0.5
  vim.g.neovide_show_border = true
  vim.g.neovide_normal_opacity = 0.8
end
