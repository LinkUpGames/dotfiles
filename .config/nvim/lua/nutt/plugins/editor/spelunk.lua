return {
  {
    "EvWilson/spelunk.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      base_mappings = {},
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
