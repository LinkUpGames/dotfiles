local group = vim.api.nvim_create_augroup("lualine-settings", { clear = true })

---Update the parameters for toggle_buffer
---@param lualine table
local toggle_buffer = function(lualine)
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
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "folke/snacks.nvim",
    "folke/noice.nvim",
  },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function(_, opts)
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local res = {
      options = {
        component_separators = {
          left = "",
          right = "",
        },
        section_separators = {
          left = "",
          right = "",
        },
        disabled_filetypes = {
          statusline = {
            "snacks_dashboard",
          },
        },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "󱇪",
            separator = {
              left = "",
              right = "",
            },
          },
        },
        lualine_b = {
          "branch",
        },
        lualine_c = {
          {
            function()
              return "󱉭 " .. require("nutt.core.utils").get_root()
            end,
            color = function()
              local status, snacks = pcall(require, "snacks")
              local color = "Comment"

              if status then
                color = snacks.util.color("Special")
              end

              return { fg = color }
            end,
            cond = function()
              return type(require("nutt.core.utils").get_root()) == "string"
            end,
          },
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              hint = " ",
              info = " ",
            },
          },
          {
            "filetype",
            separator = "",
            icon_only = true,
            padding = {
              left = 1,
              right = 0,
            },
            cond = function()
              local buffers = vim.fn.getbufinfo({ buflisted = 1 })

              return #buffers == 1
            end,
          },
          {
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
          },
        },
        lualine_x = {
					-- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return { fg = require("snacks").util.color("Statement") } end,
          },
					-- stylua: ignore
					{
					  function() return require("noice").api.status.mode.get() end,
					  cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
					  color = function() return { fg = require("snacks").util.color("Constant") } end,
					},
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return {
                fg = require("snacks").util.color("Special"),
              }
            end,
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict

              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.modified,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          {
            "location",
            padding = {
              left = 0,
              right = 1,
            },
          },
        },
        lualine_z = {
          {
            function()
              return " " .. os.date("%I:%M %p")
            end,
            separator = {
              left = "",
              right = "",
            },
          },
        },
      },
      tabline = {
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
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    -- Add the extensions over
    vim.list_extend(res.extensions, opts.extensions or {})

    return res
  end,
}
