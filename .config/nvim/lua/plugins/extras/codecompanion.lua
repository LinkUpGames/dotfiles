local processing = false

local spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_index = 1

local function update_processing_status(status)
  processing = status
end

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "CodeCompanionRequest*",
  group = vim.api.nvim_create_augroup("CodeCompanionHooks", {}),
  callback = function(request)
    if request.match == "CodeCompanionRequestStarted" then
      update_processing_status(true)
    elseif request.match == "CodeCompanionRequestFinished" then
      update_processing_status(false)
    end
  end,
})

local function get_spinner_status()
  if processing then
    spinner_index = (spinner_index % #spinner_symbols) + 1

    return spinner_symbols[spinner_index]
  else
    return "complete"
  end
end

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
  { -- Add blink code completion
    "Saghen/blink.cmp",
    opts = function(_, opts)
      -- Add Code Companion Provider
      opts.sources.providers.codecompanion = {
        name = "CodeCompanion",
        module = "codecompanion.providers.completion.blink",
        enabled = true,
      }

      -- Add Code Compantion
      table.insert(opts.sources.default, "codecompanion")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Add code companion extension
      local companion = {
        sections = {
          lualine_a = {
            function()
              return "Code Companion"
            end,
          },
          lualine_b = {
            function()
              local code = require("codecompanion")
              local chat = code.last_chat()

              if chat then
                local adapter = chat.adapter

                return adapter.name
              else
                return "unknown"
              end
            end,
          },
          lualine_z = {
            function()
              local code = require("codecompanion")
              local chat = code.last_chat()

              if chat then
                local status = chat.status

                if #status > 0 then
                  return status
                else
                  return "No Request"
                end
              else
                return "No Request"
              end
            end,
          },
          lualine_y = {
            get_spinner_status,
          },
        },
        filetypes = {
          "codecompanion",
        },
      }

      table.insert(opts.extensions, companion)
    end,
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
