return {
  "esmuellert/codediff.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = "CodeDiff",
  opts = {},
  keys = {
    {
      "<leader>gd",
      "<cmd>CodeDiff<cr>",
      desc = "Toggle Diff View",
    },
    {
      "<leader>gh",
      "<cmd>CodeDiff history %<cr>",
      desc = "Toggle File History",
    },
  },
}
