return {
  "Saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
    },
    completion = {
      documentation = {
        window = {
          border = "rounded",
        },
      },
    },
    sources = {
      min_keyword_length = function(ctx)
        return vim.bo.filetype == "markdown" and 3 or 0
      end,
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
  },
}
