return {
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    event = "BufEnter",
    opts = {
      pre_hook = function()
        -- Pairs
        vim.g.minipairs_disable = true
      end,

      post_hook = function()
        -- Pairs
        vim.g.minipairs_disable = false
      end,
    }, -- This causes the plugin setup function to be called
    keys = {
      { "<leader>Aj", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add a cursor then move down" },
      { "<leader>Ak", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add a cursor then move up" },
      {
        "<leader>Ad",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor to next selection",
      },
      {
        "<Leader>Af",
        "<Cmd>MultipleCursorsAddMatches<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to the word under the cursor",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>A", group = "Cursor" },
      },
    },
  },
}
