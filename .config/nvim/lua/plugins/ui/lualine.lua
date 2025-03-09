return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Update the seperators
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }

      opts.sections.lualine_a = {
        {
          "mode",
          icon = "󱇪",
          separator = {
            left = "",
            right = "",
          },
        },
      }

      opts.sections.lualine_y = {
        {
          "location",
          padding = {
            left = 0,
            right = 1,
          },
        },
      }

      opts.sections.lualine_z = {
        {
          function()
            return " " .. os.date("%I:%M %p")
          end,
          separator = {
            left = "",
            right = "",
          },
        },
      }

      -- Filename Section
      opts.sections.lualine_c[4] = {
        "filename",
        file_status = true,
        path = 0,
        symbols = {
          modified = "[]",
          readonly = "[󰌾]",
          unnamed = "[No Name]",
          newfile = "[]",
        },
      }

      -- Winbar
      -- opts.options.disabled_filetypes.winbar = { "snacks_dashboard" }
      -- opts.winbar = {
      --   lualine_c = {
      --     {
      --       "filetype",
      --       icon_only = true,
      --       padding = { left = 1, right = 0 },
      --       separator = {
      --         left = "",
      --         right = "",
      --       },
      --       cond = function()
      --         local buffers = vim.fn.getbufinfo({ buflisted = 1 })
      --
      --         return #buffers == 1
      --       end,
      --     },
      --     {
      --       "filename",
      --       separator = {
      --         left = "",
      --         right = "",
      --       },
      --       cond = function()
      --         local buffers = vim.fn.getbufinfo({ buflisted = 1 })
      --
      --         return #buffers == 1
      --       end,
      --     },
      --   },
      -- }
      --
      -- opts.inactve_winbar = {
      --   lualine_c = {
      --     { "filetype", icon_only = true, padding = { left = 1, right = 0 } },
      --     {
      --       "filename",
      --       separator = {
      --         left = "",
      --         right = "",
      --       },
      --     },
      --   },
      -- }
      --
      -- -- Show the file name
      -- local lualine_c = opts.sections.lualine_c
      -- opts.sections.lualine_c = {
      --   lualine_c[1],
      --   lualine_c[2],
      -- }

      return opts
    end,
  },
}
