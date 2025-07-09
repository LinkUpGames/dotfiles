local group = vim.api.nvim_create_augroup("lualine-settings", { clear = true })

---Update the parameters for toggle_buffer
---@param lualine table
local function toggle_buffer(lualine)
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  local tabs = vim.api.nvim_list_tabpages()

  if #buffers <= 1 and #tabs <= 1 then -- Hide
    vim.o.showtabline = 1
    lualine.hide({
      place = { "tabline" },
      unhide = false,
    })
  else -- Show
    vim.o.showtabline = 2
    lualine.hide({
      place = { "tabline" },
      unhide = true,
    })
  end
end

-- Show the tabline when an buffer is added, deleted
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "VimEnter", "ColorScheme", "TabNew", "TabClosed" }, {
  group = group,
  callback = function()
    vim.defer_fn(function()
      local has_lualine, lualine = pcall(require, "lualine")

      if has_lualine then
        toggle_buffer(lualine)
      end
    end, 5)
  end,
})

-- Make sure that the status line respects the width of the instance
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = group,
  callback = function()
    local has_lualine, lualine = pcall(require, "lualine")

    if has_lualine then
      local opts = lualine.get_config()

      if opts.tabline and opts.tabline.lualine_a then
        for _, component in ipairs(opts.tabline.lualine_a) do
          if type(component) == "table" and component[1] == "buffers" then
            component.max_length = vim.o.columns * (9 / 10)
          end
        end
      end

      lualine.setup(opts)
      toggle_buffer(lualine)
    end
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

          return #buffers <= 1
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
            max_length = vim.o.columns * (9 / 10),
            use_mode_colors = true,
            filetype_names = {
              snacks_picker_input = "󰍉 Picker",
              snacks_picker_list = " Explorer",
              codecompanion = "󱚣 AI Chat",
            },
          },
        },
        lualine_z = {
          {
            "tabs",
            separator = { left = "", right = "" },
            cond = function()
              local tabs = vim.api.nvim_list_tabpages()

              return #tabs >= 2
            end,
          },
        },
      }

      return opts
    end,
  },
}
