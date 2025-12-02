return {
  {
    "EvWilson/spelunk.nvim",
    event = "VeryLazy",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      base_mappings = {
        toggle = "NONE",
        add = "NONE",
        delete = "NONE",
        next_bookmark = "NONE",
        prev_bookmark = "NONE",
        search_bookmarks = "NONE",
        search_current_bookmarks = "NONE",
        search_stacks = "NONE",
        change_line = "NONE",
      },
      fuzzy_search_provider = "snacks",
    },
    keys = {
      {
        "<leader>mt",
        function()
          require("spelunk").toggle_window()
        end,
        mode = { "n" },
        desc = "[m]arks [t]oggle",
      },
      {
        "<leader>ma",
        function()
          require("spelunk").add_bookmark()
        end,
        mode = { "n" },
        desc = "[m]ark [a]dd bookmark",
      },
      {
        "<leader>ms",
        function()
          require("spelunk").search_current_marks()
        end,
        mode = { "n" },
        desc = "[m]ark [s]earch bookmarks",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      ---@module "which-key"
      ---@type wk.Spec
      spec = {
        mode = { "m" },
        { "<leader>m", group = "Marks", icon = { icon = "󰐃", color = "purple" } },
      },
    },
  },
}
