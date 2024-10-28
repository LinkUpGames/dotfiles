if true then
  return {}
end

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
      { "<leader>mj", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add a cursor then move down" },
      { "<leader>mk", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add a cursor then move up" },
      {
        "<leader>md",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor to next selection",
      },
      {
        "<Leader>mf",
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
        { "<leader>m", group = "Cursor", icon = "󰆽" },
      },
    },
  },
}
