return {
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       omnisharp = {
  --         handlers = {
  --           ["textDocument/definition"] = function(...)
  --             return require("omnisharp_extended").handler(...)
  --           end,
  --         },
  --         keys = {
  --           {
  --             "gd",
  --             function()
  --               require("omnisharp_extended").lsp_definitions()
  --             end,
  --             desc = "Goto Definition",
  --           },
  --         },
  --         enable_roslyn_analyzers = true,
  --         organize_imports_on_format = true,
  --         enable_import_completion = true,
  --       },
  --     },
  --   },
  -- },
  -- { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },
}
