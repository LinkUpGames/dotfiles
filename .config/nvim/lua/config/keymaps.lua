local keymap = vim.keymap

local opts = { noremap = true, silent = true }

-- Basic keymaps
-- Increment/Decrement
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "-", "<C-x>", opts)

-- Better Leave
keymap.set("i", "jk", "<Esc>", opts) -- exit insert mode

-- Select All
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

-- Actual Tab
keymap.set("n", "<Tab>", "<Tab>", opts) -- Remap tab to itself
keymap.set("i", "<C-BS>", "<C-W>", opts) -- Delete words with backspace
keymap.set("i", "<C-l>", "<Del>", opts) -- Forward delete character
