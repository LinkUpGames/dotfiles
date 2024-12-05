local vaults = {
  {
    name = "school",
    path = "/Development/School/Obsidian/",
  },
}

local events = {}
local workspaces = {}

for _, vault in ipairs(vaults) do
  local BufReadPre = "BufReadPre " .. vim.fn.expand("~") .. vault.path .. "**.md"
  local BufNewFile = "BufNewFile " .. vim.fn.expand("~") .. vault.path .. "**.md"

  table.insert(events, BufReadPre)
  table.insert(events, BufNewFile)

  table.insert(workspaces, {
    name = vault.name,
    path = vim.fn.expand("~") .. vault.path,
  })
end

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
  event = events,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = workspaces,
  },
  cond = function()
    local obsidian_dir = vim.fn.finddir(".obsidian", vim.fn.getcwd())

    return obsidian_dir ~= ""
  end,
}
