-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Showup dashboard after no buffers opened

-- Lualine
-- vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "BufWinLeave", "BufNew" }, {
--   callback = function()
--     local lualine = require("lualine")
--     local buffers = vim.fn.getbufinfo({ buflisted = 1 })
--
--     if #buffers > 1 then
--       lualine.hide({ place = { "tabline" }, unhide = true })
--     else
--       lualine.hide({ place = { "tabline" }, unhide = false })
--     end
--   end,
-- })
