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
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = workspaces,
    },
    cond = function() -- Only run in an obsidian based vault
      local obsidian = vim.fs.find({ ".obsidian" }, { upward = true })[1]

      if obsidian then
        vim.o.conceallevel = 1
      end

      return obsidian
    end,
    keys = {
      {
        "<leader>op",
        "<cmd>Obsidian paste_img<cr>",
        mode = { "n" },
        ft = "markdown",
        desc = "Paste the clipboard image to the markdown file",
      },
      {
        "<leader>os",
        "<cmd>Obsidian search<cr>",
        mode = { "n" },
        ft = "markdown",
        desc = "Search for a specific file in Obsidian Vault",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>o", group = "Obsidian", icon = "󰆽" },
      },
    },
  },
}
