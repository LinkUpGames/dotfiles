return {
  "Saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      cmdline = function()
        local type = vim.fn.getcmdtype()

        if type == "/" or type == "?" then
          return { "buffer" }
        end

        if type == ":" then
          return { "cmdline" }
        end

        return {}
      end,

      min_keyword_length = function()
        return vim.bo.filetype == "markdown" and 3 or 0
      end,
    },
    completion = {
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline" and not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        end,
      },
    },
    keymap = {
      cmdline = {
        preset = "enter",
        ["<C-space>"] = {},
        ["<Tab>"] = { "show", "hide", "show_documentation", "hide_documentation" },
      },
    },
  },
}
