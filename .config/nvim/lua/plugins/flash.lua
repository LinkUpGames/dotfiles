return {
  "folke/flash.nvim",
  enabled = true,
  opts = {
    modes = {
      char = {
        enabled = false,
      },
      search = {
        enabled = false,
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
      desc = "Jump Forward To",
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
}
