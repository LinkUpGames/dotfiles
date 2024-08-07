local theme = "tokyonight"

return {
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- Set transparent background.
      fluo_color = "orange",
      mode = "bright",
      aggressive_spell = true,
    },
  },
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
    "Tsuzat/NeoSolarized.nvim",
    priority = 1000,
    opts = {
      style = "light",
      transparent = false,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    opts = {
      options = {
        transparent = true,
        dim_inactive = false,
      },
      groups = {
        all = {
          LineNrAbove = {
            bg = "none",
            fg = "#a32166",
          },
          LineNr = {
            fg = "#e83393",
            bg = "none",
          },
          LineNrBelow = {
            fg = "#a32166",
            bg = "none",
          },
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = theme,
    },
  },
}
