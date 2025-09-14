local opt = vim.opt

-- Cursor
local old_guicursor = vim.o.guicursor
vim.o.guicursor = old_guicursor .. ",n-v-c:block-blinkon700-blinkoff400,i-ci-ve:ver25-blinkon700-blinkoff400"

-- Setup The column
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-- Sign Column
opt.relativenumber = true
opt.number = true
opt.ruler = false
opt.sidescrolloff = 8

-- Clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

-- Editing
opt.autowrite = true
opt.expandtab = true -- Use spaces
opt.jumpoptions = "view"
opt.smartindent = true
opt.shiftround = true
opt.shiftwidth = 2
opt.wrap = false
opt.undofile = true
opt.tabstop = 2
opt.timeoutlen = 500
opt.smoothscroll = true
opt.autoindent = true
opt.confirm = true

-- Buffer
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.updatetime = 200
opt.list = true -- Show some invisible characters
opt.foldlevel = 99
opt.scrolloff = 4
opt.termguicolors = true
opt.linebreak = true
opt.spelllang = { "en" }
opt.cursorline = false -- no cursorline

-- Search
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- If included mized case is search, then search sensitive
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"

-- Status Column
opt.splitright = true -- Put new windows right of current
-- opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.laststatus = 3
opt.showmode = false

-- Misc
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Windows
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current

-- Copy/Paste
local paste = function()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

-- Clipboard
-- vim.g.clipboard = {
--   name = "OSC 52",
--   copy = {
--
--     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--     ["-"] = require("vim.ui.clipboard.osc52").copy("-"),
--   },
--   paste = {
--     ["+"] = paste,
--     ["-"] = paste,
--   },
-- }

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono"

  vim.g.neovide_window_blurred = true
  vim.g.neovide_opacity = 0.5
  vim.g.neovide_show_border = true
  vim.g.neovide_normal_opacity = 0.8
end
