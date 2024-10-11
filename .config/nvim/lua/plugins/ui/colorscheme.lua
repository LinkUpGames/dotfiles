local theme = ""

local themes = {
  "eldritch",
  "tokyonight",
  "catppuccin",
  "vscode",
  "dracula-soft",
  "dracula",
}

local i = math.random(os.time()) % #themes
i = i == 0 and #themes or i

theme = themes[i]

return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        floats = "transparent",
        sidebars = "transparent",
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
    "tokyonight.nvim",
    lazy = false,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl)
        hl.LineNrAbove = {
          fg = "#8b46b0",
          bold = true,
          bg = "none",
        }

        hl.LineNr = {
          fg = "#ce7dfa",
          bg = "none",
          bold = true,
        }

        hl.LineNrBelow = {
          fg = "#8b46b0",
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
      highlight_overrides = {
        all = function()
          return {
            LineNrAbove = {
              fg = "#ded69b",
              bold = true,
              bg = "none",
            },
            LineNr = {
              fg = "#faf5cf",
              bg = "none",
              bold = true,
            },
            LineNrBelow = {
              fg = "#ded69b",
              bg = "none",
              bold = true,
            },
          }
        end,
      },
    },
  },
  {
    "Mofiqul/vscode.nvim",
    opts = function(_, opts)
      local c = require("vscode.colors").get_colors()

      local extend = {
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

      return vim.tbl_deep_extend("force", opts, extend)
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    opts = function()
      local dracula = require("dracula")

      local colors = dracula.colors()

      return {
        transparent_bg = true,
        italic_comment = true,
        overrides = {
          LineNrAbove = {
            ---@diagnostic disable-next-line
            fg = colors.orange,
            bg = "none",
            bold = true,
          },
          LineNrBelow = {
            ---@diagnostic disable-next-line
            fg = colors.orange,
            bg = "none",
            bold = true,
          },
          LineNr = {
            ---@diagnostic disable-next-line
            fg = colors.bright_blue,
            bg = "none",
            bold = true,
          },
          NormalFloat = {
            fg = "none",
            bg = "none",
          },
          FlashBackdrop = {
            ---@diagnostic disable-next-line
            fg = colors.nontext,
          },
          FlashLabel = {
            bg = "#fd0178",
          },
        },
      }
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = theme,
    },
  },
}
