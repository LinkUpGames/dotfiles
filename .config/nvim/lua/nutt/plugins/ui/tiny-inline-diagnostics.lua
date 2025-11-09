return {
  "rachartier/tiny-inline-diagnostic.nvim",
  priority = 1000,
  event = "VeryLazy",
  config = function()
    require("tiny-inline-diagnostic").setup({
      transparent_bg = true,
      transparent_cursorline = true,
      options = {
        add_messages = {
          display_count = true,
        },
        multilines = {
          enabled = true,
          trim_whitespaces = true,
        },
        break_line = {
          enabled = true,
        },
      },
    })

    vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
  end,
}
