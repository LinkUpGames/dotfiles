---@module "lazy"
---@type LazySpec
return {
  -- Code Companion
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    ---@module "codecompanion"
    opts = {
      interactions = {
        chat = {
          adapter = "opencode",
          roles = {
            ---The header name for the LLM's messages
            ---@type string|fun(adapter: unknown): string
            llm = function(adapter)
              local name = adapter.formatted_name

              local display_name = string.format("Clanker 󰚩 (%s)", name)

              return display_name
            end,
          },
          keymaps = {
            send = {
              modes = {
                n = "<CR>",
                i = "<CR>",
              },
              description = "Send the message over",
            },
            close = {
              modes = {
                n = "<leader>ad",
              },
              description = "Close chat buffer",
            },
          },
        },
      },
      opts = {
        system_prompt = [[
        ## Notes
        - You are helping me with my codebase.
        - You are a senior developer that has expertise in any programming language and tool and a strong suit in math
        - I am trying to learn and understand. Make sure your responses can be understood by most software developers. Make sure that your responses are good for learning and teaching others.
        - Make sure that your responses are not too verbose. Make sure that your response are short to medium. Give me an overall insight of what I ask. If I ask for more information later on in further prompts, then please extend and explain more in detail what I wish to know.
        - You must use the tools that I specify. If no tool is specified, then make sure to ask more information.
        - Most questions will be programming based. When I ask a non-programming question, it will be clear because I will specify it's a non-programming question.
        - Respond in a markdown format.
        ]],
      },
      adapters = {
        http = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              schema = {
                model = {
                  default = "gemini-2.0-flash-exp",
                },
              },
              env = {
                api_key = os.getenv("GEMINI_API_KEY"),
              },
            })
          end,
        },
        opencode = function()
          return require("codecompanion.adapters").extend("opencode", {
            env = os.getenv("OPENCODE_API_KEY"),
          })
        end,
        acp = {
          opencode = function()
            return require("codecompanion.adapters").extend("opencode", {
              env = os.getenv("OPENCODE_API_KEY"),
            })
          end,
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
          show_token_count = true,
          show_context = true,
        },
      },
    },
    keys = {
      {
        "<leader>aj",
        mode = { "n" },
        function()
          require("codecompanion").toggle()
        end,
        desc = "Open a new chat buffer",
      },
      {
        "<leader>ap",
        mode = { "n", "x" },
        function()
          require("codecompanion").actions({})
        end,
        desc = "AI Available Actions",
      },
      {
        "<leader>aj",
        mode = { "x" },
        "<cmd>CodeCompanionChat Add<cr>",
        desc = "Paste the selected into the latest AI Chat",
      },
    },
  },
  -- Add blink code completion
  {
    "Saghen/blink.cmp",
    opts = {
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    },
  },
  -- Which Key
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "AI Chat", icon = "󰚩" },
      },
    },
  },
  -- Markview
  {
    "OXY2DEV/markview.nvim",
    ft = function(_, ft)
      table.insert(ft, "codecompanion")

      return ft
    end,
    opts = function(_, opts)
      table.insert(opts.preview.filetypes, "codecompanion")

      local preview = {
        ignore_buftypes = {},
      }

      opts.preview = vim.tbl_deep_extend("keep", opts.preview, preview)
    end,
  },
}
