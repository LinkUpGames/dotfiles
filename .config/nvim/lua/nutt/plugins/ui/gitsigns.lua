return {
  {
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
      {
        "<leader>gs]",
        "<cmd>Gitsigns nav_hunk next<cr>",
        mode = "n",
        desc = "Next Hunk",
      },
      {
        "<leader>gs[",
        "<cmd>Gitsigns nav_hunk prev<cr>",
        mode = "n",
        desc = "Previous Hunk",
      },
      {
        "<leader>gsr",
        "<cmd>Gitsigns reset_hunk<cr>",
        mode = { "n", "v" },
        desc = "Reset Hunk",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        mode = { "n", "v" },
        { "<leader>gs", group = "Git Signs", icon = { icon = "", color = "cyan" } },
      },
    },
  },
}
