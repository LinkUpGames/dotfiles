return {
  -- Tree sitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        keys = {
          -- Text Object select
          {
            "af",
            function()
              require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end,
            desc = "Select outer function",
            mode = { "x", "o" },
          },
          {
            "if",
            function()
              require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end,
            desc = "Select inner function",
            mode = { "x", "o" },
          },
          {
            "ac",
            function()
              require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
            end,
            desc = "Select outer class",
            mode = { "x", "o" },
          },
          {
            "ic",
            function()
              require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
            end,
            desc = "Select inner class",
            mode = { "x", "o" },
          },

          -- Text Object Functions
          {
            "]f",
            function()
              require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
            end,
            desc = "Goto start of next outer function",
            mode = { "n", "x", "o" },
          },
          {
            "]F",
            function()
              require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
            end,
            desc = "Goto end of next outer function",
            mode = { "n", "x", "o" },
          },
          {
            "[f",
            function()
              require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
            end,
            desc = "Goto start of previous outer function",
            mode = { "n", "x", "o" },
          },
          {
            "[F",
            function()
              require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
            end,
            desc = "Goto end of previous outer function",
            mode = { "n", "x", "o" },
          },

          -- Text Object Class
          {
            "]c",
            function()
              require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
            end,
            desc = "Goto start of next outer class",
            mode = { "n", "x", "o" },
          },
          {
            "]C",
            function()
              require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
            end,
            desc = "Goto end of next outer class",
            mode = { "n", "x", "o" },
          },
          {
            "[c",
            function()
              require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
            end,
            desc = "Goto start of previous outer class",
            mode = { "n", "x", "o" },
          },
          {
            "[C",
            function()
              require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
            end,
            desc = "Goto end of precious class",
            mode = { "n", "x", "o" },
          },

          -- Text Object Parameters
          {
            "[a",
            function()
              require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.outer", "textobjects")
            end,
            desc = "Goto start of previous parameter",
            mode = { "n", "x", "o" },
          },
          {
            "[A",
            function()
              require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.outer", "textobjects")
            end,
            desc = "Goto end of previous parameter",
            mode = { "n", "x", "o" },
          },
          {
            "]a",
            function()
              require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.outer", "textobjects")
            end,
            desc = "Goto start of next parameter",
            mode = { "n", "x", "o" },
          },
          {
            "]A",
            function()
              require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.outer", "textobjects")
            end,
            desc = "Goto end of next parameter",
            mode = { "n", "x", "o" },
          },
        },
      },
    },
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    lazy = false,
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    branch = "main",
    config = function(_, opts)
      local treesitter = require("nvim-treesitter")

      -- setup
      treesitter.setup(opts)

      -- Install the necessary plugins
      treesitter.install(opts.ensure_installed)

      -- Create autocmd
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(event)
          local ft = event.match
          local lang, buf = vim.treesitter.language.get_lang(ft), event.buf

          -- Check if the language is installed
          local installed = vim.treesitter.language.add(lang or "")
          if not installed then
            local languages = treesitter.get_available()

            local available = vim.tbl_contains(languages, lang)

            if available then
              vim.notify_once("Installing treesitter parser for " .. lang, vim.log.levels.INFO)
              treesitter.install({ lang }):wait(30 * 1000)
            end
          end

          -- Only run the treesitter if file exists
          if lang then
            -- Load treesiterr
            local ok = pcall(vim.treesitter.language.add, lang)
            if not ok then
              -- Parser not available
              return
            end

            -- Start treesitter
            if opts.highlight.enable then
              pcall(vim.treesitter.start, buf)
            end

            -- Better folding
            if opts.folds.enable then
              vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end

            -- Intents
            if opts.indent.enable then
              vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end
        end,
      })
    end,
    opts = {
      ensure_installed = { "bash", "html", "lua", "luadoc", "markdown", "markdown_inline" },
      auto_install = true,
      folds = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
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
