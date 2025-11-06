-- vim.api.nvim_create_autocmd("FileType", {
--   callback = function(event)
--     local ok = pcall(vim.treesitter.start, event.buf)
--     local ft = event.match
--
--     local treesitter = require("nvim-treesitter")
--     local installed = treesitter.get_installed()
--
--     for i, value in ipairs(installed) do
--     end
--   end,
-- })

return {
  -- Tree sitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
    lazy = false,
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    branch = "main",
    config = function(_, opts)
      local treesitter = require("nvim-treesitter")

      -- setup
      treesitter.setup(opts)

      -- Create autocmd
      local installed = treesitter.get_installed()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(event)
          local ft, lang, buf = event.match, vim.treesitter.language.get_lang(event.match), event.buf
          local exists = vim.tbl_contains(installed, ft)

          -- Only run the treesitter if file exists
          if exists then
            pcall(vim.treesitter.start, buf)
            -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end,
      })
    end,
    -- event = { "VeryLazy" },
    -- main = "nvim-treesitter.configs",
    ---@type TSConfig?
    opts = {
      ensure_installed = { "bash", "html", "lua", "luadoc", "markdown", "markdown_inline" },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = {
      "ensure_installed",
    },
  },
}
