return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function(_, opts)
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

    local center = {
      {
        action = 'lua require("persistence").load()',
        desc = " Restore Session",
        icon = " ",
        key = "s",
      },
      {
        action = LazyVim.pick(),
        desc = " Find File",
        icon = " ",
        key = "f",
      },
      { action = LazyVim.pick.config_files(), desc = " Config", icon = " ", key = "c" },
      {
        action = "Lazy",
        desc = " Lazy",
        icon = "󰒲 ",
        key = "l",
      },
      {
        action = "qa",
        desc = " Quit",
        icon = " ",
        key = "q",
      },
    }

    logo = string.rep("\n", 8) .. logo .. "\n\n"
    opts.config.header = vim.split(logo, "\n")
    opts.config.center = center

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end
  end,
}
