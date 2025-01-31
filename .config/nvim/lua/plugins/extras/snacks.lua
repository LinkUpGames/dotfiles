return {
  "folke/snacks.nvim",

  opts = function(_, opts)
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

    local keys = {
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
    }

    -- Update Dashboard
    opts.dashboard = {
      -- width = 100,
      enabled = true,
      pane_gap = 1,
      preset = {
        header = logo,
        keys = keys,
      },
      sections = {
        { section = "header" },
        { section = "keys", padding = 1, gap = 1 },
        { section = "startup" },
      },
    }

    -- Indent
    opts.indent = {
      enabled = true,
      indent = {
        only_scope = false,
        enabled = true,
      },
      scope = {
        enabled = true,
      },
      chunk = { enabled = true, only_current = true },
    }

    -- Scope
    opts.scope = {
      enabled = true,
    }

    -- Picker
    opts.picker = {
      formatters = {
        file = {
          filename_first = true,
        },
      },
      sources = {
        files = {
          hidden = true,
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
    }
  end,
}
