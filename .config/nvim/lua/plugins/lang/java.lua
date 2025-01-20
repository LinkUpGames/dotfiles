return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      jdtls = function(opts)
        opts.dap_main = false

        opts.settings = {
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

        return opts
      end,
    },
  },
}
