return {
  "Saghen/blink.cmp",
  opts = function(_, opts)
    opts.sources.cmdline = function()
      local type = vim.fn.getcmdtype()

      if type == "/" or type == "?" then
        return { "buffer" }
      end

      if type == ":" then
        return { "cmdline" }
      end

      return {}
    end
  end,
}
