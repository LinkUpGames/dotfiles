return {
  -- {
  --   "BranimirE/fix-auto-scroll.nvim",
  --   config = true,
  --   event = "VeryLazy",
  -- },
  -- {
  --   "ibhagwan/smartyank.nvim",
  --   opts = {
  --     hightlight = false,
  --   },
  -- },
  {
    "mistricky/codesnap.nvim",
    event = "BufEnter",
    build = "make",
    enabled = function()
      return false

      -- local sys = jit.os
      --
      -- return sys ~= "Windows"
    end,
    opts = {
      watermark = "Code Snippet",
      mac_window_bar = false,
      bg_color = "#535c68",
      code_font_family = "Hack Nerd Font",
      title = "Snippet",
      save_path = "~/Pictures/",
      has_breadcrumbs = true,
      watermark_font_family = "Hack Nerd Font",
    },
    -- enabled = false,
  },
}
