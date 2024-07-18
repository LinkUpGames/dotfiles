return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    keymaps = {
      ["q"] = { "actions.close", mode = { "n" } },
      ["-"] = { "actions.parent", mode = { "n" } },
      ["_"] = { "actions.open_cwd", mode = { "n" } },
      ["<CR>"] = { "actions.select", mode = { "n" } },
    },
    view_options = {
      show_hidden = true,
    },
    use_default_keymaps = false,
  },
  keys = {
    { "<leader>e", "<CMD>Oil --float<CR>", mode = { "n" }, { desc = "Open parent directory" } },
  },
}
