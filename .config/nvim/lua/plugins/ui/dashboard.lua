return {
  "folke/snacks.nvim",
  lazy = false,
  opts = function()
    local logo = [[
███████╗ ██████╗ ██████╗██╗     ███████╗███████╗██╗ █████╗ ███████╗████████╗███████╗███████╗     █████╗     ██╗ ██████╗
██╔════╝██╔════╝██╔════╝██║     ██╔════╝██╔════╝██║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔════╝    ██╔══██╗██╗███║██╔═████╗
█████╗  ██║     ██║     ██║     █████╗  ███████╗██║███████║███████╗   ██║   █████╗  ███████╗    ╚██████║╚═╝╚██║██║██╔██║
██╔══╝  ██║     ██║     ██║     ██╔══╝  ╚════██║██║██╔══██║╚════██║   ██║   ██╔══╝  ╚════██║     ╚═══██║██╗ ██║████╔╝██║
███████╗╚██████╗╚██████╗███████╗███████╗███████║██║██║  ██║███████║   ██║   ███████╗███████║     █████╔╝╚═╝ ██║╚██████╔╝
╚══════╝ ╚═════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚══════╝     ╚════╝     ╚═╝ ╚═════╝

Marcos Cevallos
Development
   ]]
    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      {
        icon = " ",
        key = "c",
        desc = "Config",
        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
      },
      { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    }

    return {
      ---@type snacks.Config
      dashboard = {
        enabled = true,
        preset = {
          header = logo,
          keys = keys,
        },
      },
    }
  end,
}

-- return {
--   "nvimdev/dashboard-nvim",
--   event = "VimEnter",
--   opts = function(_, opts)
--     local logo = [[
-- ███████╗ ██████╗ ██████╗██╗     ███████╗███████╗██╗ █████╗ ███████╗████████╗███████╗███████╗     █████╗     ██╗ ██████╗
-- ██╔════╝██╔════╝██╔════╝██║     ██╔════╝██╔════╝██║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔════╝    ██╔══██╗██╗███║██╔═████╗
-- █████╗  ██║     ██║     ██║     █████╗  ███████╗██║███████║███████╗   ██║   █████╗  ███████╗    ╚██████║╚═╝╚██║██║██╔██║
-- ██╔══╝  ██║     ██║     ██║     ██╔══╝  ╚════██║██║██╔══██║╚════██║   ██║   ██╔══╝  ╚════██║     ╚═══██║██╗ ██║████╔╝██║
-- ███████╗╚██████╗╚██████╗███████╗███████╗███████║██║██║  ██║███████║   ██║   ███████╗███████║     █████╔╝╚═╝ ██║╚██████╔╝
-- ╚══════╝ ╚═════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚══════╝     ╚════╝     ╚═╝ ╚═════╝
--
-- Marcos Cevallos
-- Development
--     ]]
--
--     local center = {
--       {
--         action = 'lua require("persistence").load()',
--         desc = " Restore Session",
--         icon = " ",
--         key = "s",
--       },
--       {
--         action = LazyVim.pick(),
--         desc = " Find File",
--         icon = " ",
--         key = "f",
--       },
--       { action = LazyVim.pick.config_files(), desc = " Config", icon = " ", key = "c" },
--       {
--         action = "Lazy",
--         desc = " Lazy",
--         icon = "󰒲 ",
--         key = "l",
--       },
--       {
--         action = "qa",
--         desc = " Quit",
--         icon = " ",
--         key = "q",
--       },
--     }
--
--     logo = string.rep("\n", 8) .. logo .. "\n\n"
--     opts.config.header = vim.split(logo, "\n")
--     opts.config.center = center
--
--     for _, button in ipairs(opts.config.center) do
--       button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
--       button.key_format = "  %s"
--     end
--   end,
-- }
