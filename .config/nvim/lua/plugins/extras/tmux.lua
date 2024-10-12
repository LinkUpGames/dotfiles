return {
  "christoomey/vim-tmux-navigator",
  keys = {
    { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "n", "x" }, desc = "Go to the previous pane" },
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "x" }, desc = "Got to the left pane" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "x" }, desc = "Got to the down pane" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "x" }, desc = "Got to the up pane" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "x" }, desc = "Got to the right pane" },
  },
}
