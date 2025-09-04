return {
  -- Snacks
  {
    "folke/snacks.nvim",
    opts = function()
      local logo = [[
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
   ]]

      ---@type snacks.Config
      return {
        animate = {},
        dashboard = {
          enabled = true,
          pane_gap = 1,
          preset = {
            header = logo,
            keys = {
              { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
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
          sections = {
            { section = "header" },
            { section = "keys", padding = 1, gap = 1 },
            { section = "startup" },
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
          chunk = { enabled = true, only_current = true },
        },
        picker = {
          enabled = true,
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
        image = {
          enabled = true,
        },
      }
    end,
    config = function(_, opts)
      require("snacks").setup(opts)

      -- Extra functionality
      -- Snack Options
      Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")

      -- LazyGit
      local map = vim.keymap.set
      if vim.fn.executable("lazygit") == 1 then
        map("n", "<leader>gg", function()
          Snacks.lazygit({ cwd = LazyVim.root.git() })
        end, { desc = "Lazygit (Root Dir)" })
        map("n", "<leader>gG", function()
          Snacks.lazygit()
        end, { desc = "Lazygit (cwd)" })
        map("n", "<leader>gf", function()
          Snacks.picker.git_log_file()
        end, { desc = "Git Current File History" })
        map("n", "<leader>gl", function()
          Snacks.picker.git_log({ cwd = LazyVim.root.git() })
        end, { desc = "Git Log" })
        map("n", "<leader>gL", function()
          Snacks.picker.git_log()
        end, { desc = "Git Log (cwd)" })
      end

      -- Zen Mode
      Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
      Snacks.toggle.zen():map("<leader>uz")
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
      {
        "<leader>,",
        function()
          local snacks = require("snacks")
          snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          local snacks = require("snacks")
          snacks.picker.pick("grep")
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader><space>",
        function()
          local snacks = require("snacks")
          snacks.picker.pick("files")
        end,
        desc = "Find Files (Root Dir)",
      },
      {
        "<leader>n",
        function()
          local snacks = require("snacks")
          snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
    },
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    extensions = {
      {
        sections = {
          lualine_a = {
            {
              function()
                return " Explorer"
              end,
              separator = { left = "", right = "" },
            },
          },
          lualine_b = { "branch" },
          lualine_z = {
            {
              function()
                return " " .. os.date("%I:%M %p")
              end,
              separator = { left = "", right = "" },
            },
          },
        },
        filetypes = { "snacks_picker_list" }, -- double check with :echo &filetype
      },
    },
  },
}
