return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim",
  },
  ---@module 'blink.cmp'
  ---@param opts blink.cmp.Config
  opts = function(_, opts)
    ---@type blink.cmp.Config
    local options = {
      appearance = {
        nerd_font_variant = "mono",
        kind_icons = Utils.icons.kinds,
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = true,
        },
        list = {
          selection = {
            preselect = true, -- I want to know how this goes with the ghost text
            auto_insert = false,
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        min_keyword_length = function(ctx)
          return vim.bo.filetype == "markdown" and 3 or 0
        end,
      },
      keymap = {
        preset = "enter",
      },
      cmdline = {
        enabled = true,
        sources = function()
          local type = vim.fn.getcmdtype()

          if type == "/" or type == "?" then
            return { "buffer" }
          end

          if type == ":" then
            return { "cmdline" }
          end

          return {}
        end,
        keymap = {
          preset = "enter",
          ["<C-space>"] = {},
          ["<Tab>"] = { "show", "hide", "show_documentation", "hide_documentation" },
        },
        completion = {
          ghost_text = {
            enabled = true, -- Show the completion
          },
          menu = {
            auto_show = false,
          },
        },
      },
    }

    return options
  end,
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
}
