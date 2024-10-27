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

      -- Show the file name
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

      -- Extensions
      local oil = {
        sections = {
          lualine_a = {
            function()
              return " OIL"
            end,
          },
          lualine_b = {
            function()
              local ok, oil = pcall(require, "oil")

              -- Load oil file
              if ok then
                ---@diagnostic disable-next-line: param-type-mismatch
                return vim.fn.fnamemodify(oil.get_current_dir(), ":~")
              else
                return "ERROR"
              end
            end,
          },
        },
        filetypes = {
          "oil",
        },
      }

      table.insert(opts.extensions, oil)
    end,
  },
}
