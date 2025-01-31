return {
  { -- cmd = "Oil",
    lazy = false,
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = false,
      keymaps = {
        ["q"] = {
          function()
            require("oil").discard_all_changes()
            require("oil").close()
          end,
          mode = { "n" },
        },
        ["-"] = { "actions.parent", mode = { "n" } },
        ["_"] = { "actions.open_cwd", mode = { "n" } },
        ["<CR>"] = { "actions.select", mode = { "n" } },
      },
      view_options = {
        show_hidden = true,
        natural_order = false,
      },
      use_default_keymaps = false,
    },
    keys = {
      {
        "<leader>e",
        function()
          local oil = require("oil")

          oil.toggle_float()
        end,
        mode = { "n" },
        desc = "Open current directory",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Add the oil extension
      local oil = {
        sections = {
          lualine_a = {
            function()
              return " OIL"
            end,
          },
          lualine_b = {
            function()
              local ok, oil = pcall(require, "oil")

              -- Load oil file
              if ok then
                ---@diagnostic disable-next-line: param-type-mismatch
                return vim.fn.fnamemodify(oil.get_current_dir(), ":~")
              else
                return "ERROR"
              end
            end,
          },
        },
        filetypes = {
          "oil",
        },
      }

      table.insert(opts.extensions, oil)
    end,
  },
}
