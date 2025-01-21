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

    opts.sources.min_keyword_length = function()
      return vim.bo.filetype == "markdown" and 3 or 0
    end

    return opts
  end,
}
