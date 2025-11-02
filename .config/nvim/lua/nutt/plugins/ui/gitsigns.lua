return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile", "BufWritePre" },
  opts = {},
  keys = {
    {
      "<leader>gsd",
      "<cmd>Gitsigns toggle_word_diff<cr>",
      mode = "n",
      desc = "Toggle intra-line word-diff",
    },
    {
      "<leader>gsp",
      "<cmd>Gitsigns toggle_current_line_blame<cr>",
      mode = "n",
      desc = "Toggle line blame",
    },
    {
      "<leader>gsh",
      "<cmd>Gitsigns preview_hunk<cr>",
      mode = "n",
      desc = "Preview hunk",
    },
  },
}
