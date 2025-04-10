return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      palette = "default",
      transparent = true,
      styles = {
        floats = "transparent",
        sidebars = "transparent",
        functions = {
          italic = true,
          bold = true,
        },
        keywords = {
          italic = true,
        },
      },
      on_highlights = function(hl)
        hl.LineNrAbove = {
          fg = "#40b4e3",
          bold = true,
          bg = "none",
        }

        hl.LineNr = {
          fg = "#9ee4ff",
          bg = "none",
          bold = true,
        }

        hl.LineNrBelow = {
          fg = "#40b4e3",
          bg = "none",
          bold = true,
        }
      end,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, colors)
        -- local col = require("tokyonight.colors.moon")
        -- col.magenta

        hl.LineNrAbove = {
          fg = colors.blue1,
          bold = true,
          bg = "none",
        }

        hl.LineNr = {
          fg = colors.magenta,
          bg = "none",
          bold = true,
        }

        hl.LineNrBelow = {
          fg = colors.blue1,
          bg = "none",
          bold = true,
        }
      end,
    },
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {

      term_colors = true,
      transparent_background = true,
      flavour = "mocha",
      custom_highlights = function(colors)
        return {
          LineNrAbove = {
            fg = colors.maroon,
            bg = "none",
            bold = true,
          },
          LineNr = {
            fg = colors.yellow,
            bg = "none",
            bold = true,
          },
          LineNrBelow = {
            fg = colors.maroon,
            bg = "none",
            bold = true,
          },
        }
      end,
    },
  },
  {
    "Mofiqul/vscode.nvim",
    opts = function(_, _)
      local c = require("vscode.colors").get_colors()

      return {
        -- style = "light",
        transparent = true,
        underline_links = true,
        italic_comments = true,
        group_overrides = {
          LineNrAbove = {
            fg = c.vscLightBlue,
            bg = "none",
            bold = true,
          },
          LineNr = {
            fg = c.vscLightRed,
            bg = "none",
            bold = true,
          },
          LineNrBelow = {
            fg = c.vscLightBlue,
            bg = "none",
            bold = true,
          },
          NormalFloat = { fg = "none", bg = "none" },
          FlashBackdrop = { fg = c.vscGray },
          FlashLabel = { bg = "#fd0178" },
        },
      }
    end,
  },
  {
    "maxmx03/fluoromachine.nvim",
    opts = function(_, _)
      local colors = require("fluoromachine.colors.fluoromachine")

      return {
        theme = "retrowave",
        transparent = true,
        glow = false,
        styles = {
          comments = { italic = true },
          functions = { bold = true, italic = true },
          variables = { italic = true },
        },
        overrides = {
          NormalFloat = {
            fg = "none",
            bg = "none",
          },
          LineNr = {
            bold = true,
            fg = colors.pink,
            bg = "none",
          },
          LineNrAbove = {
            fg = colors.cyan,
            bg = "none",
          },
          LineNrBelow = {
            fg = colors.cyan,
            bg = "none",
          },
          FlashBackdrop = {
            fg = colors.fg,
          },
          FlashLabel = { bg = colors.purple, fg = colors.bgdark },
        },
      }
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    opts = function()
      local colors = require("cyberdream.colors")

      return {
        transparent = true,
        italic_comments = true,
        highlights = {
          NormalFloat = {
            fg = "none",
            bg = "none",
          },
          LineNr = {
            fg = colors.default.red,
            bg = "none",
          },
          LineNrAbove = {
            fg = colors.default.orange,
            bg = "none",
          },
          LineNrBelow = {
            fg = colors.default.orange,
            bg = "none",
          },
        },
      }
    end,
  },
  {
    "ribru17/bamboo.nvim",
    opts = function()
      local pallete = require("bamboo.palette").vulgaris

      return {
        style = "multiplex",
        code_style = {
          variables = {
            bold = true,
          },
        },
        highlights = {
          LineNr = {
            fg = pallete.orange,
            bg = "none",
          },
          LineNrAbove = {
            fg = pallete.coral,
            bg = "none",
          },
          LineNrBelow = {
            fg = pallete.coral,
            bg = "none",
          },
        },
      }
    end,
  },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   opts = function()
  --     local colors = require("gruvbox").palette
  --     -- vim.o.background = "dark"
  --
  --     return {
  --       contrast = "hard",
  --       overrides = {
  --         LineNr = {
  --           fg = colors.bright_orange,
  --           bg = "none",
  --         },
  --         LineNrAbove = {
  --           fg = colors.light_green_soft,
  --           bg = "none",
  --         },
  --         LineNrBelow = {
  --           fg = colors.light_green_soft,
  --           bg = "none",
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "LinkUpGames/jumble.nvim",
    opts = {
      themes = {
        "eldritch",
        "tokyonight",
        "catppuccin",
        "vscode",
        "cyberdream",
        "fluoromachine",
        "bamboo-multiplex",
      },
    },
  },
}
