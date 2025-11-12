return {
  -- Snacks
  {
    lazy = false,
    priority = 1000,
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = true,
        page_gap = 1,
        preset = {
          header = [[
 _____                                                                                 _____ 
( ___ )                                                                               ( ___ )
 |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   | 
 |   | ███████╗ ██████╗ ██████╗██╗     ███████╗███████╗        █████╗     ██╗ ██████╗  |   | 
 |   | ██╔════╝██╔════╝██╔════╝██║     ██╔════╝██╔════╝       ██╔══██╗██╗███║██╔═████╗ |   | 
 |   | █████╗  ██║     ██║     ██║     █████╗  ███████╗       ╚██████║╚═╝╚██║██║██╔██║ |   | 
 |   | ██╔══╝  ██║     ██║     ██║     ██╔══╝  ╚════██║        ╚═══██║██╗ ██║████╔╝██║ |   | 
 |   | ███████╗╚██████╗╚██████╗███████╗███████╗███████║██╗     █████╔╝╚═╝ ██║╚██████╔╝ |   | 
 |   | ╚══════╝ ╚═════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝     ╚════╝     ╚═╝ ╚═════╝  |   | 
 |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___| 
(_____)                                                                               (_____)
Marcos Cevallos
Development
   ]],
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
      indent = {
        indent = {
          only_scope = false,
          enabled = true,
          hl = { "SnacksIndent1", "SnacksIndent2", "SnacksIndent3", "SnacksIndent4" },
        },
        scope = {
          enabled = true,
        },
        chunk = {
          enabled = true,
          only_current = true,
        },
      },
      scope = {
        enabled = true,
      },
      toggle = {
        enabled = true,
      },
      image = {
        enabled = true,
      },
      scroll = {
        enabled = true,
      },
      input = {
        enabled = true,
      },
      notifier = {
        enabled = true,
      },
      picker = {
        layout = {
          preset = function()
            return vim.o.columns >= 120 and "telescope" or "vertical"
          end,
        },
        formatters = {
          file = {
            filename_first = true,
          },
        },
        ---@class snacks.picker.sources.Config
        sources = {
          files = {
            hidden = true,
          },
          explorer = {
            hidden = true,
            jump = {
              close = false,
            },
            win = {
              list = {
                keys = {
                  ["-"] = "explorer_up",
                  ["<c-c>"] = "",
                },
              },
            },
          },
        },
        icons = {
          ui = {
            hidden = "",
            live = "󰍉",
          },
        },
        win = {
          input = {
            keys = {
              ["<c-h>"] = false,
              ["<c-l>"] = false,
              ["<c-j>"] = { "preview_scroll_left", mode = { "i", "n" } },
              ["<c-k>"] = { "preview_scroll_right", mode = { "i", "n" } },
            },
          },
        },
      },
    },
    -- Make sure that the status column has the correct padding
    init = function()
      vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
    end,
    keys = {
      {
        "<leader>E",
        function()
          local snacks = require("snacks")
          snacks.picker.explorer()
        end,
        mode = { "n" },
        desc = "Open the file explorer",
      },

      -- Picker
      {
        "<leader>,",
        function()
          require("snacks").picker.buffers()
        end,
        desc = "Buffers",
        mode = { "n" },
      },
      {
        "<leader>/",
        function()
          require("snacks").picker.grep({
            cwd = Utils.get_root(),
          })
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>:",
        function()
          require("snacks").picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader><space>",
        function()
          require("snacks").picker.files({
            cwd = Utils.get_root(),
          })
        end,
        desc = "Find Files (Root Dir)",
      },
      {
        "<leader>sh",
        function()
          require("snacks").picker.notifications()
        end,
        desc = "[S]earch Notification [H]istory",
      },
      {
        "<leader>sd",
        function()
          require("snacks").picker.git_diff()
        end,
        desc = "[S]earch Git [D]iff",
      },
      {
        "<leader>sb",
        function()
          require("snacks").picker.diagnostics_buffer()
        end,
        desc = "[S]earch [B]uff Diagnostics",
      },
      {
        "<leader>sl",
        function()
          require("snacks").picker.git_log()
        end,
        desc = "[S]earch [L]og Files",
      },
      {
        "<leader>sL",
        function()
          require("snacks").picker.git_log_file()
        end,
        desc = "[S]earch [L]og Current File",
      },

      -- Buffer
      {
        "<S-h>",
        "<cmd>bprevious<cr>",
        desc = "Prev Buffer",
        mode = "n",
      },
      {
        "<S-l>",
        "<cmd>bnext<cr>",
        desc = "Next Buffer",
        mode = "n",
      },
      {
        "<leader>bo",
        function()
          require("snacks").bufdelete.other()
        end,
        mode = "n",
        desc = "Delete Other Buffers",
      },
      {
        "<leader>bd",
        function()
          require("snacks").bufdelete.delete()
        end,
        desc = "Delete Buffer",
        mode = "n",
      },
      {
        "<leader>bD",
        "<cmd>:bd<cr>",
        desc = "Delete Buffer and Window",
        mode = "n",
      },

      -- Windows
      {
        "<leader>wm",
        function()
          require("snacks").zen.zoom()
        end,
        desc = "Zoom Window",
        mode = "n",
      },

      -- Lazy Git
      {
        "<leader>gg",
        function()
          local root = Utils.get_root()

          if vim.fn.executable("lazygit") == 1 then
            require("snacks").lazygit({
              cwd = root,
            })
          else
            vim.notify("LazyGit is not installed!")
          end
        end,
        desc = "LazyGit (Root Directory)",
        mode = "n",
      },
      {
        "<leader>gG",
        function()
          if vim.fn.executable("lazygit") == 1 then
            require("snacks").lazygit()
          else
            vim.notify("LazyGit is not installed!")
          end
        end,
        desc = "LazyGit (CWD)",
        mode = "n",
      },

      -- Icons
      {
        "<leader>si",
        function()
          require("snacks").picker.icons()
        end,
        desc = "[S]earch [I]cons",
        mode = "n",
      },

      -- Terminal
      {
        "<c-/>",
        function()
          require("snacks").terminal.toggle(nil, {
            toggle = true,
            cwd = Utils.get_root(),
          })
        end,
        desc = "Terminal (Root Dir)",
        mode = "n",
      },
      {
        "<c-/>",
        "<cmd>close<cr>",
        desc = "Close Terminal",
        mode = "t",
      },
    },
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    event = "VeryLazy",
    opts = function(_, opts)
      local explorer = {
        sections = {
          lualine_a = {
            {
              function()
                return " Explorer"
              end,
              separator = {
                left = "",
                right = "",
              },
            },
          },
          lualine_b = { "branch" },
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
        filetypes = {
          "snacks_picker_list",
        },
      }

      opts.extensions = opts.extensions or {}
      table.insert(opts.extensions, explorer)

      -- Insert the status
      local lualine_x = opts.sections.lualine_x or {}
      table.insert(lualine_x, 1, require("snacks").profiler.status())

      opts.sections.lualine_x = lualine_x

      return opts
    end,
  },
}
