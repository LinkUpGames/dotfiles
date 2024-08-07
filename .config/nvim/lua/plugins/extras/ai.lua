return {
  { "Exafunction/codeium.nvim", lazy = true, opts = {
    enable_chat = true,
  }, enabled = false },
  {
    "frankroeder/parrot.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    cond = os.getenv("GEMINI_API_KEY") ~= nil,
    opts = {
      chat_free_cursor = true,
      toggle_target = "popup",
      chat_shortcut_respond = { modes = { "n" }, shortcut = "<CR>" },
      chat_shortcut_delete = { modes = { "n" }, shortcut = "<leader>ad" },
      chat_confirm_delete = false,
      providers = {
        gemini = {
          api_key = os.getenv("GEMINI_API_KEY"),
        },
      },
      agents = {
        chat = {
          name = "Gemini",
          model = {
            model = "gemini-1.5-flash",
            system_prompt = "You are helping me with my codebase",
            provider = "gemini",
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
