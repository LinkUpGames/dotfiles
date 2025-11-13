return {
  "rachartier/tiny-inline-diagnostic.nvim",
  priority = 1000,
  event = "VeryLazy",
  config = function()
    require("tiny-inline-diagnostic").setup({
      transparent_bg = false,
      transparent_cursorline = true,
      hi = {
        mixing_color = "None",
      },
      options = {
        softwrap = 20,
        set_arrow_to_diag_color = true,
        show_source = {
          if_many = true,
        },
        add_messages = {
          display_count = true,
        },
        multilines = {
          enabled = true,
          trim_whitespaces = true,
          -- always_show = true,
        },
        break_line = {
          enabled = true,
        },
        overflow = {
          padding = 5,
        },
        override_open_float = true,
      },
    })

    vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
  end,
}
