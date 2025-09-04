local opt = vim.opt

-- Map leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Term gui colors
opt.termguicolors = true
opt.clipboard = "unnamedplus"
opt.background = "dark"

-- Blinking Cursor
local old_guicursor = vim.o.guicursor
vim.o.guicursor = old_guicursor .. ",n-v-c:block-blinkon700-blinkoff400,i-ci-ve:ver25-blinkon700-blinkoff400"

-- Setup The column
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-- Copy/Paste
local paste = function()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

-- Clipboard update
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
  vim.g.neovide_opacity = 0.5
  vim.g.neovide_show_border = true
  vim.g.neovide_normal_opacity = 0.8
end

-- General settings

opt.autowrite = true -- Enable auto write
opt.cursorline = false -- No cursor line
opt.expandtab = true -- Use spaces instead of tabs

opt.ignorecase = true
opt.laststatus = 3

opt.jumpoptions = "view"
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 4
opt.linebreak = true
opt.foldlevel = 99
opt.list = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.showmode = false -- replaced by status line
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
opt.timeout = false -- Indefinite chord time
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.smoothscroll = true
