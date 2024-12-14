return {
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

    ---@class snacks.Config
    ---@field scroll? snacks.scroll.Config
    ---@field input? snacks.input.Config
    ---@field indent? snacks.indent.Config
    ---@field scope? snacks.scope.Config
    return {
      ---@type snacks.Config
      notifier = {
        enabled = true,
      },
      scroll = {
        enabled = true,
      },
      input = {
        enabled = true,
      },
      indent = {
        enabled = true,
        indent = {
          only_scope = false,
          enabled = true,
        },
        scope = {
          enabled = true,
        },
        chunk = { enabled = true, only_current = true },
      },
      scope = {
        enabled = true,
      },
      dashboard = {
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
      },
    }
  end,
}
