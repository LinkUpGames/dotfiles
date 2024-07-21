return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Update the seperators
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }

    opts.sections.lualine_y = {
      {
        "location",
        icon = "󱇪",
        padding = { left = 0, right = 1 },
      },
    }

    opts.sections.lualine_z = {
      function()
        return " " .. os.date("%I:%M %p")
      end,
    }

    -- Extensions
    table.insert(opts.extensions, "oil")
  end,
}
