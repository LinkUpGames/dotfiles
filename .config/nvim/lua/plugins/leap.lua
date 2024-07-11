return {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  keys = {
    {
      "t",
      function()
        require("leap").leap({ forward = true })
      end,
      mode = { "n", "x", "o" },
      desc = "Leap Forward To",
    },
    {
      "T",
      function()
        require("leap").leap({ backward = true })
      end,
      mode = { "n", "x", "o" },
      desc = "Leap Backward To",
    },
  },
  enabled = false,
}
