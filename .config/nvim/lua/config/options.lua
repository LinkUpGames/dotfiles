-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"

local old_guicursor = vim.o.guicursor

vim.g.mapleader = " "
vim.o.guicursor = old_guicursor .. ",n-v-c:block-blinkon700-blinkoff400,i-ci-ve:ver25-blinkon700-blinkoff400"

-- Setup The column
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

vim.o.cursorline = false

vim.g.lazyvim_picker = "snacks"
