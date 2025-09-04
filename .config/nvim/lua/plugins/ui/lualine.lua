return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "folke/snacks.nvim" },
  },
  event = "VeryLazy",
  init = function()
    vim.g.lualine_last_status = vim.o.laststatus

    if vim.fn.argc(-1) > 0 then
      -- Set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- Hide the status line on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- Get requirements
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    -- Components
    ---Root directory component for showcasing there in the world we are opening this file from
    ---@param opts? table Extra options to be passed to the current root directory component
    local root_dir_component = function(opts)
      opts = vim.tbl_extend("force", {
        cwd = false,
        subdirectory = true,
        parent = true,
        other = true,
        icon = "󱉭 ",
        color = function()
          return { fg = Snacks.util.color("Special") }
        end,
      }, opts or {})

      ---Get the current working directory
      ---@return string current working directory
      local get = function()
        local cwd = vim.fn.getcwd()
        local root = vim.lsp.buf.list_workspace_folders()[1] or cwd
        local name = vim.fs.basename(root)

        -- Check were the location is
        if root == cwd then
          return opts.cwd and name
        elseif root:find(cwd, 1, true) then
          return opts.subdirectory and name
        elseif cwd:find(root, 1, true) == 1 then
          return opts.parent and name
        else
          return opts.other and name
        end
      end

      return {
        function()
          local val = get()
          return val and ((opts.icon and opts.icon .. " ") .. val) or ""
        end,
        cond = function()
          return type(get()) == "string"
        end,
        color = opts.color,
      }
    end

    -- Icons
    local icons = {
      separators = {
        filled = { right = "", left = "" },
        outline = { right = "", left = "" },
      },
      diagnostics = {
        error = " ",
        warn = " ",
        info = " ",
        hint = " ",
      },
      git = {
        added = " ",
        modified = " ",
        removed = " ",
      },
    }

    -- Update lualine
    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        component_separators = icons.separators.outline,
        section_separators = icons.separators.filled,
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = { "branch" },
        lualine_c = {
          root_dir_component(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.error,
              warn = icons.diagnostics.error,
              info = icons.diagnostics.info,
              hint = icons.diagnostics.hint,
            },
          },
          {
            "filetype",
            icon_only = true,
            separator = "",
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
          Snacks.profiler.status(),
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return {
                fg = Snacks.util.color("Special"),
              }
            end,
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict

              -- Check for diff and changes
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "location", padding = {
            left = 0,
            right = 1,
          } },
        },
        lualine_z = {

          function()
            return " " .. os.date("%I:%M %p")
          end,
        },
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    return opts
  end,
  opts_extend = {
    "extensions",
  },
}
