-- Show the tabline when an buffer is added, deleted
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "VimEnter" }, {
  callback = function()
    vim.defer_fn(function()
      local lualine = require("lualine")
      local buffers = vim.fn.getbufinfo({ buflisted = 1 })

      if #buffers <= 1 then -- Hide
        lualine.hide({
          place = { "tabline" },
          unhide = false,
        })
      else -- Show
        lualine.hide({
          place = { "tabline" },
          unhide = true,
        })
      end
    end, 5)
  end,
})

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

      -- Filename Section -> Show only if there is one buffer opened
      opts.sections.lualine_c[3].cond = function()
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })

        return #buffers == 1
      end
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
        cond = function()
          local buffers = vim.fn.getbufinfo({ buflisted = 1 })

          return #buffers == 1
        end,
      }

      -- Tabline
      opts.tabline = {
        lualine_a = {
          {
            "buffers",
            separator = { left = "", right = "" },
            right_padding = 2,
            symbols = { alternate_file = "" },
            filetype_names = {
              snacks_picker_input = "󰍉 Picker",
              snacks_picker_list = " Explorer",
            },
          },
        },
      }

      return opts
    end,
  },
}
