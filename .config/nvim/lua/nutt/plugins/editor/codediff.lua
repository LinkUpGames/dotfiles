return {
  "esmuellert/codediff.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = "CodeDiff",
  opts = {},
  keys = {
    {
      "<leader>gD",
      "<cmd>CodeDiff<cr>",
      desc = "Toggle Diff View",
    },
  },
}
