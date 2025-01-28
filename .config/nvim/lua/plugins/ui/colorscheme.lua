-- Themes that we can use
local themes = {
  "eldritch",
  "tokyonight",
  "catppuccin",
  "vscode",
  "onedark",
  "fluoromachine",
}

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

---Return the date as a table with the year, month and day
---@param date_string any
local parse_date = function(date_string)
  -- Split the date string by hyphens
  local year, month, day = date_string:match("(%d+)-(%d+)-(%d+)")

  -- Convert the parts to integers
  year = tonumber(year)
  month = tonumber(month)
  day = tonumber(day)

  -- Return the year, month, and day
  return { year = year, month = month, day = day }
end

---Compares a previous and current date and checks if the current date is more than a day away
---@param current any
---@param previous any
local next_day = function(current, previous)
  local current_date = parse_date(current)
  local previous_date = parse_date(previous)

  if current_date.year > previous_date.year then -- Different Years
    return true
  elseif current_date.month > previous_date.month then -- Different months
    return true
  else
    if current_date.day > previous_date.day then
      return true
    end
  end

  return false
end

---Returns a random colorscheme from the themes table
---@return string The colorscheme
local random_theme = function()
  local i = math.random(os.time()) % #themes
  i = i == 0 and #themes or i

  return themes[i]
end

---Get a colorschema from the table that does not match the one provided
---@param colorscheme string The colorscheme
local get_truly_random = function(colorscheme)
  local newcolorscheme
  repeat
    newcolorscheme = random_theme()
  until colorscheme ~= newcolorscheme

  return newcolorscheme
end

---Get the theme that is in the saved file and check if it's the next day
---@return string colorschem The colorscheme
local get_theme = function()
  local colorscheme
  local date = os.date("%Y-%m-%d")

  -- Check the saved file
  local data = check_file()

  if data.date ~= nil and data.date ~= "" then -- Save file exists
    local savedcolorscheme = data.colorscheme
    -- Check if it's the next day and get new theme
    if next_day(date, data.date) then
      colorscheme = get_truly_random(savedcolorscheme)

      save_file(colorscheme, tostring(date))
    else
      colorscheme = savedcolorscheme
    end
  else -- Create a saved file
    colorscheme = random_theme()
    save_file(colorscheme, tostring(date))
  end

  return colorscheme
end

-- Get the current theme for the day
local theme = get_theme()

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
    "maxmx03/fluoromachine.nvim",
    opts = function(_, _)
      return {
        -- theme = "retrowave",
        transparent = true,
        glow = false,
        overrides = {
          NormalFloat = {
            fg = "none",
            bg = "none",
          },
          LineNr = {
            bold = true,
            fg = "#FFFFFF",
            bg = "none",
          },
          LineNrAbove = {
            fg = "#ffffff",
            bg = "none",
          },
          LineNrBelow = {
            fg = "#ffffff",
            bg = "none",
          },
        },
      }
    end,
  },
  {
    "navarasu/onedark.nvim",
    opts = function(_, _)
      local palette = require("onedark.palette")
      return {
        style = "deep",
        transparent = true,
        term_colors = true,
        code_style = {
          comment = "italic",
          keywords = "bold",
          functions = "bold,italic",
          variables = "italic",
        },
        lualine = {
          transparent = false,
        },
        highlights = {
          LineNrAbove = {
            fg = palette.deep.green,
            bold = true,
            bg = "none",
          },
          LineNr = {
            fg = palette.deep.purple,
            bold = true,
            bg = "none",
          },
          LineNrBelow = {
            fg = palette.deep.green,
            bold = true,
            bg = "none",
          },
          NormalFloat = { fg = "none", bg = "none" },
          FlashBackdrop = { fg = palette.deep.grey },
          FlashLabel = { bg = "#fd0178" },
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
