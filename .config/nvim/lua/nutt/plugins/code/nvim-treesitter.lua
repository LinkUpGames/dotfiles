---@module "lazy"
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
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
  lazy = false,
  build = ":TSUpdate",
  ---@param opts TreesitterSetupOpts
  config = function(_, opts)
    local ts = require("nvim-treesitter")

    -- State tracking for async parser loading
    local parsers_loaded = {}
    local parsers_pending = {}
    local parsers_failed = {}

    local ns = vim.api.nvim_create_namespace("treesitter.async")

    --- Helper to start highlighting and indentation
    --- @param buf integer The buffer
    --- @param lang string The language
    local function start(buf, lang)
      local ok = pcall(vim.treesitter.start, buf, lang)

      if ok then
        -- Enable indentation
        if vim.treesitter.query.get(lang, "indents") and opts.indent then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        -- Enable Folds
        if vim.treesitter.query.get(lang, "folds") and opts.folds then
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
      end

      return ok
    end

    -- Install core parsers after lazy.nvim finishes loading all plugins
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyDone",
      once = true,
      callback = function()
        ts.install(opts.ensure_installed, {
          max_jobs = 8,
        })
      end,
    })

    -- Decoration provider for async parser loading
    vim.api.nvim_set_decoration_provider(ns, {
      on_start = vim.schedule_wrap(function()
        if #parsers_pending == 0 then
          return false
        end

        for _, data in ipairs(parsers_pending) do
          if vim.api.nvim_buf_is_valid(data.buf) then
            if start(data.buf, data.lang) then
              parsers_loaded[data.lang] = true
            else
              parsers_failed[data.lang] = true
            end
          end
        end

        parsers_pending = {}
      end),
    })

    -- Get all the languages available for tree sitter at once
    local languages = ts.get_available()
    local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

    -- Auto-install parsers and enable highlighting on FileType
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      desc = "Enable treesitter highlighting and indentation (non-blocking)",
      callback = function(event)
        if vim.tbl_contains(opts.ignore_filetypes, event.match) then
          return
        end

        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf
        local available = vim.tbl_contains(languages, lang)

        if not available or parsers_failed[lang] then
          return
        end

        if parsers_loaded[lang] then
          -- Parser already loaded, start immediately (fast path)
          start(buf, lang)
        else
          -- Queue for async loading
          table.insert(parsers_pending, { buf = buf, lang = lang })
        end

        -- Auto-install missing parsers (async, no-op if already installed)
        ts.install({ lang })
      end,
    })
  end,
  ---@class TreesitterSetupOpts
  opts = {
    ensure_installed = {
      "bash",
      "comment",
      "gitcommit",
      "gitignore",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "zsh",
    },
    ignore_filetypes = {
      "txt",
      "mason",
      "lazy",
      "snacks_dashboard",
      "snacks_notif",
      "snacks_win",
      "checkhealth",
      "noice",
    },
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
    "ignore_filetypes",
  },
}
