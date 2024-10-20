---Save the colorscheme and date to a save file
---@param colorscheme string The colorscheme to save
---@param date string The date saved as yyyy-mm-dd
local save_file = function(colorscheme, date)
  local file = io.open(vim.fn.stdpath("data") .. "/colorscheme", "w+")

  if file then
    file:write(colorscheme, "\n")
    file:write(date, "\n")
    file:close()
  end
end

---Checks the current file and returns the date and colorscheme saved
---@return table The table contains the colorscheme and date
local check_file = function()
  local table = {
    colorscheme = "",
    date = "",
  }

  local file = io.open(vim.fn.stdpath("data") .. "/colorscheme", "r")
  if file then
    local colorscheme, date = file:read("*l"), file:read("*l")

    table.colorscheme = colorscheme
    table.date = date
  end

  return table
end

local theme = ""

local themes = {
  "eldritch",
  "tokyonight",
  "catppuccin",
  "vscode",
  "rose-pine",
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
    "rose-pine/neovim",
    name = "rose-pine",

    opts = function()
      local rose = require("rose-pine.palette")

      return {
        variant = "moon",
        styles = {
          transparency = true,
        },
        highlight_groups = {
          LineNrAbove = {
            fg = rose.subtle,
            bold = true,
            bg = "none",
          },
          LineNr = {
            fg = rose.leaf,
            bg = "none",
            bold = true,
          },
          LineNrBelow = {
            fg = rose.subtle,
            bg = "none",
            bold = true,
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
