local workspaces = {} -- The workspaces in which obsidian will run

-- Run Obsidian in any directory
table.insert(workspaces, {
  name = "obsidian",
  path = function()
    return assert(vim.fn.getcwd())
  end,
  overrides = {
    notes_subdir = vim.NIL,
    new_notes_location = "current_dir",
    templates = {
      folder = vim.NIL,
    },
    disable_frontmatter = true,
  },
})

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = workspaces,
  },
  cond = function() -- Only run in an obsidian based vault
    local obsidian_dir = vim.fn.finddir(".obsidian", vim.fn.getcwd())

    return obsidian_dir ~= ""
  end,
}
