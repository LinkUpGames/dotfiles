local opt = vim.opt

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
opt.wrap = false
opt.undofile = true
opt.tabstop = 2
opt.timeoutlen = 500
opt.smoothscroll = true
opt.autoindent = true

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

-- Misc
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Windows
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
