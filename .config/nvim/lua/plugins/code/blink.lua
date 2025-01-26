return {
  "Saghen/blink.cmp",

  opts = function(_, opts)
    opts.sources.cmdline = function()
      local type = vim.fn.getcmdtype()

      if type == "/" or type == "?" then
        return { "buffer" }
      end

      if type == ":" then
        return { "cmdline" }
      end

      return {}
    end

    opts.sources.min_keyword_length = function()
      return vim.bo.filetype == "markdown" and 3 or 0
    end

    -- Don't show until shown in cmd_line
    opts.completion = {
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline" and not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        end,
      },
    }

    -- Add the cmdline keymaps to run only when wanted
    opts.keymap.cmdline = {
      preset = "enter",
      ["<C-space>"] = {},
      ["<Tab>"] = { "show", "hide", "show_documentation", "hide_documentation" },
    }

    return opts
  end,
}
