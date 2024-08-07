return {
  { "Exafunction/codeium.nvim", lazy = true, opts = {
    enable_chat = true,
  }, enabled = false },
  {
    "robitx/gp.nvim",
    config = function()
      local opts = {
        providers = {
          googleai = {
            disabled = false,
            endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
            secret = os.getenv("GEMINI_API_KEY"),
          },
        },

        default_chat_agent = "Gemini",
        default_command_agent = "Gemini",

        agents = {
          {
            provider = "googleai",
            name = "Gemini",
            chat = true,
            disable = false,
            model = { model = "gemini-1.5-flash" },
            system_prompt = require("gp.defaults").code_system_prompt,
          },
        },
      }

      require("gp").setup(opts)
    end,
    enabled = true,
    keys = {
      {
        "<leader>aj",
        "<CMD>GpChatToggle split<CR>",
        mode = "n",
        desc = "Toggle AI Chat",
      },
      {
        "<leader>ak",
        ":GpChatNew split<CR>",
        mode = "n",
        desc = "Open a new AI Chat",
      },
      {
        "<leader>aj",
        ":'<,'>GpChatToggle split<CR>",
        mode = { "x", "o" },
        desc = "Toggle AI Chat",
      },
      {
        "<leader>ak",
        "<CMD>'<,'>GpChatNew split<CR>",
        mode = { "x", "o" },
        desc = "Open a new AI Chat",
      },
      {
        "<leader>ad",
        "<CMD>GpChatDelete<CR>",
        mode = { "n" },
        desc = "Delete the ai chat",
      },
      {
        "<leader>a<CR>",
        "<CMD>GpChatRespond<CR>",
        mode = "n",
        desc = "AI Chat Respond",
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
