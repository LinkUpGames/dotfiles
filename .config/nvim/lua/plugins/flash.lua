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
      false,
    },
    {
      "S",
      false,
    },
    {
      "r",
      false,
    },
    {
      "R",
      false,
    },
    {
      "<c-s>",
      false,
    },
  },
}
