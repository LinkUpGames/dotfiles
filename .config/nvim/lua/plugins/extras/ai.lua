return {
  -- {
  --   "olimorris/codecompanion.nvim",
  --   config = true,
  --   opts = {
  --     adapters = {
  --       gemini = function()
  --         return require("codecompanion.adapters").extend("gemini", {
  --           env = {
  --             api_key = os.getenv("GEMINI_API_KEY"),
  --           },
  --         })
  --       end,
  --     },
  --     strategies = {
  --       chat = {
  --         adapter = "gemini",
  --       },
  --       inline = {
  --         adapter = "gemini",
  --       },
  --       agent = {
  --         adapter = "gemini",
  --       },
  --     },
  --   },
  -- },
  {
    "frankroeder/parrot.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    cond = os.getenv("GEMINI_API_KEY") ~= nil,
    opts = {
      style_popup_border = "rounded",
      chat_user_prefix = "💬:",
      llm_prefix = "🤖: ",
      chat_free_cursor = true,
      toggle_target = "popup",
      chat_shortcut_respond = { modes = { "n", "i" }, shortcut = "<CR>" },
      chat_shortcut_delete = { modes = { "n" }, shortcut = "<leader>ad" },
      chat_confirm_delete = false,
      providers = {
        gemini = {
          api_key = os.getenv("GEMINI_API_KEY"),
          topic_prompt = "You are helping me with my codebase",
          topic = {
            model = "gemini-1.5-flash",
          },
        },
      },
    },
    keys = {
      { "<leader>aj", "<CMD>PrtChatToggle popup<CR>", mode = { "n" }, desc = "Toggle AI Chat" },
      { "<leader>ak", "<CMD>PrtChatNew popup<CR>", mode = { "n" }, desc = "Open new AI Chat" },
      {
        "<leader>aj",
        ":'<,'>PrtChatPaste popup<CR>",
        mode = { "x" },
        desc = "Paste the selected into the latest AI Chat",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "AI Chat", icon = "󰆽" },
      },
    },
  },
}
