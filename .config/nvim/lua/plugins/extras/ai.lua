return {
  -- Code Companion
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    opts = {
      ---@return string
      system_prompt = function()
        return "You are helping me with my codebase"
      end,
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemini-1.5-flash",
              },
            },
            env = {
              api_key = os.getenv("GEMINI_API_KEY"),
            },
          })
        end,
      },
      strategies = {
        chat = {
          roles = {
            llm = "🤖",
            user = "Me",
          },
          adapter = "gemini",
          keymaps = {
            send = {
              modes = {
                n = "<CR>",
                i = "<CR>",
              },
              description = "Send the message over",
            },
          },
        },
        inline = {
          adapter = "gemini",
        },
        agent = {
          adapter = "gemini",
        },
      },
      display = {
        action_palette = {
          provider = "default",
        },
        chat = {
          window = {
            layout = "vertical",
          },
          intro_message = "Start The Chat! Press ? for options",
          show_settings = true,
        },
      },
    },
    keys = {
      { "<leader>aj", mode = { "n" }, "<cmd>CodeCompanionChat Toggle<cr>", desc = "Open a new chat buffer" },
      { "<leader>ap", mode = { "n", "x" }, "<cmd>CodeCompanionActions<cr>" },
      {
        "<leader>aj",
        mode = { "x" },
        "<cmd>CodeCompanionChat Add<cr>",
        desc = "Paste the selected into the latest AI Chat",
      },
      {
        "<leader>ad",
        function()
          local code = require("codecompanion")
          local chat = code.last_chat()

          if chat then
            chat.close(chat)
          end
        end,
        mode = { "n" },
        desc = "Close the last chat buffer",
      },
    },
  },

  -- Parrot
  -- {
  --   "frankroeder/parrot.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   event = "VeryLazy",
  --   cond = os.getenv("GEMINI_API_KEY") ~= nil,
  --   opts = {
  --     style_popup_border = "rounded",
  --     chat_user_prefix = "💬:",
  --     llm_prefix = "🤖:",
  --     chat_free_cursor = true,
  --     toggle_target = "popup",
  --     online_model_selection = true,
  --     chat_shortcut_respond = { modes = { "n", "i" }, shortcut = "<CR>" },
  --     chat_shortcut_delete = { modes = { "n" }, shortcut = "<leader>ad" },
  --     chat_confirm_delete = false,
  --     providers = {
  --       gemini = {
  --         api_key = os.getenv("GEMINI_API_KEY"),
  --         topic_prompt = "You are helping me with my codebase",
  --         topic = {
  --           model = "gemini-1.5-flash",
  --         },
  --       },
  --     },
  --   },
  --   keys = {
  --     { "<leader>aj", "<CMD>PrtChatToggle popup<CR>", mode = { "n" }, desc = "Toggle AI Chat" },
  --     { "<leader>ak", "<CMD>PrtChatNew popup<CR>", mode = { "n" }, desc = "Open new AI Chat" },
  --     {
  --       "<leader>aj",
  --       ":'<,'>PrtChatPaste popup<CR>",
  --       mode = { "x" },
  --       desc = "Paste the selected into the latest AI Chat",
  --     },
  --   },
  -- },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "AI Chat", icon = "󰆽" },
      },
    },
  },
}
