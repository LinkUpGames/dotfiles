return {
  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = {
  --     linters_by_ft = {
  --       java = { "checkstyle" },
  --     },
  --     ---@type table<string, table>
  --     linters = {
  --       checkstyle = {
  --         condition = function(ctx)
  --           return vim.fs.find({ "checkstyle.xml" }, { path = ctx.filename, upward = true })[1]
  --         end,
  --       },
  --     },
  --   },
  --
  -- },
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      jdtls = function(opts)
        opts.dap_main = false

        local settings = {
          java = {
            format = {
              enabled = true,
            },
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
          },
        }

        opts.settings = vim.tbl_deep_extend("force", opts.settings, settings)

        return opts
      end,
    },
    enabled = false,
  },
}
