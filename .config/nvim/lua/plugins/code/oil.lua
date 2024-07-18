return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    default_file_explorer = true,
    keymaps = {
      ["q"] = {
        function()
          require("oil").discard_all_changes()
          require("oil").close()
        end,
        mode = { "n" },
      },
      ["-"] = { "actions.parent", mode = { "n" } },
      ["_"] = { "actions.open_cwd", mode = { "n" } },
      ["<CR>"] = { "actions.select", mode = { "n" } },
    },
    view_options = {
      show_hidden = true,
      natural_order = false,
    },
    use_default_keymaps = false,
  },
  keys = {
    { "<leader>e", "<CMD>Oil --float<CR>", mode = { "n" }, { desc = "Open parent directory" } },
  },
}
