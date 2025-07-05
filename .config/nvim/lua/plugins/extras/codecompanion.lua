-- Lualine Component
---Check if the currently opened buffer is a codecompanion buffer
---@param bufnr integer The buffer id
---@return boolean bool if the current buffer is a codecompanion one
local is_codecompanion = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  -- Check the filetype
  local filetype = "codecompanion"
  local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

  if ft == filetype then
    return true
  end

  return false
end

---Get the current status of the codecompanion response
---@return string status The status of the current code companion buffer
local ai_status = function()
  local current = vim.api.nvim_get_current_buf()
  local codecompanion = is_codecompanion(current)

  if codecompanion then
    ---@type boolean
    local modifiable = vim.api.nvim_get_option_value("modifiable", { buf = current })

    local status = (not modifiable and "󰟶 Thinking...") or " Ask me anything"

    return status
  end

  return ""
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
        coder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "code",
            schema = {
              model = {
                default = "mistral:latest",
              },
            },
          })
        end,
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
      strategies = {
        chat = {
          adapter = "coder",
          roles = {
            llm = "🤖",
            user = "Me",
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
        inline = {
          adapter = "coder",
        },
        agent = {
          adapter = "coder",
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
          -- show_settings = true,
        },
      },
    },
    keys = {
      { "<leader>aj", mode = { "n" }, "<cmd>CodeCompanionChat Toggle<cr>", desc = "Open a new chat buffer" },
      { "<leader>ap", mode = { "n", "x" }, "<cmd>CodeCompanionActions<cr>", desc = "AI Available Actions" },
      {
        "<leader>aj",
        mode = { "x" },
        "<cmd>CodeCompanionChat Add<cr>",
        desc = "Paste the selected into the latest AI Chat",
      },
      -- {
      --   "<leader>ad",
      --   function()
      --     local code = require("codecompanion")
      --     local chat = code.last_chat()
      --
      --     if chat then
      --       chat.close(chat)
      --     end
      --   end,
      --   mode = { "n" },
      --   desc = "Close the last chat buffer",
      -- },
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
  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Add code companion extension
      local companion = {
        sections = {
          lualine_a = {
            {
              function()
                return "Code Companion"
              end,
              separator = {
                left = "",
                right = "",
              },
            },
          },
          lualine_b = {
            function()
              local code = require("codecompanion")
              local chat = code.last_chat()

              if chat then
                local adapter = chat.adapter

                return "󰚩 " .. adapter.name
              else
                return "󰚩 unknown"
              end
            end,
          },
          lualine_z = {
            {
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
              separator = {
                left = "",
                right = "",
              },
            },
          },
          lualine_y = {
            ai_status,
          },
        },
        filetypes = {
          "codecompanion",
        },
      }

      table.insert(opts.extensions, companion)

      return opts
    end,
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
