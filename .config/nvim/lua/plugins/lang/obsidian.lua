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

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  event = events,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = workspaces,
  },
}
