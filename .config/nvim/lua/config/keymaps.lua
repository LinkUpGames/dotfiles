local keymap = vim.keymap

local opts = { noremap = true, silent = true }

-- Basic keymaps
keymap.set("i", "jj", "<Esc>", opts) -- exit insert mode
keymap.set("n", "<C-a>", "ggVG", opts)
keymap.set("n", "<Tab>", "<Tab>", opts) -- Remap tab to itself
keymap.set("i", "<C-BS>", "<C-W>", opts)
keymap.set("i", "<C-l>", "<Del>", opts) -- Forward delete character
