return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
      modes = {
        char = {
          enabled = false,
        },
        search = {
          enabled = true,
        },
      },
    },
    keys = {
      {
        "t",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "Jump To",
      },
      {
        "T",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "x", "o" },
        desc = "Jump Treesitter",
      },
      {
        "s",
        mode = { "n", "x", "o" },
        false,
      },
      {
        "S",
        mode = { "n", "x", "o" },
        false,
      },
      {
        "r",
        mode = { "n", "x", "o" },
        false,
      },
      {
        "R",
        mode = { "n", "x", "o" },
        false,
      },
      {
        "<c-s>",
        mode = { "n", "x", "o" },
        false,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<a-s>"] = false,
              ["s"] = false,
              ["t"] = { "flash", mode = { "n" } },
              ["T"] = false,
            },
          },
        },
      },
    },
  },
}
