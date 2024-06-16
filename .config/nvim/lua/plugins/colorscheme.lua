local theme = "tokyonight"

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = true,
    opts = {
      terminal_colors = true,
      transparent_mode = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "tokyonight.nvim",
    lazy = true,
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
    "talha-akram/noctis.nvim",
    lazy = true,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_float_style = "dim"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
    end,
  },
  {
    "catppuccin/nvim",
    lazy = true,
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
    "eldritch-theme/eldritch.nvim",
    lazy = true,
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
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      theme = {
        highlights = {
          LineNrBelow = {
            fg = "#cc5896",
            bg = "none",
            bold = true,
          },
          LineNr = {
            fg = "#fc92cb",
            bg = "none",
            bold = true,
          },
          LineNrAbove = {
            fg = "#cc5896",
            bg = "none",
            bold = true,
          },
        },
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
    "maxmx03/fluoromachine.nvim",
    lazy = true,
    opts = {
      glow = false,
      theme = "retrowave",
      transparent = true,
      overrides = {
        ["LineNrAbove"] = {
          fg = "#8b46b0",
          bold = true,
          bg = "none",
        },
        ["LineNr"] = {
          fg = "#ce7dfa",
          bg = "none",
          bold = true,
        },
        ["LineNrBelow"] = {
          fg = "#8b46b0",
          bg = "none",
          bold = true,
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
