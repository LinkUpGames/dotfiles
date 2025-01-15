return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      jdtls = function(opts)
        opts.dap_main = false

        return opts
      end,
    },
  },
}
