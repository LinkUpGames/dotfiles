-- if true then
--   return {}
-- end

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdLineEnter" },
  dependencies = {
    "hrsh7th/cmp-cmdline",
  },
  lazy = true,
  opts = function(_, _)
    local cmp = require("cmp")
    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline({
        ["<CR>"] = {
          c = function(default)
            if cmp.visible() then
              return cmp.confirm({ select = true })
            end

            default()
          end,
        },
      }),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })

    -- '/' cmdline setup
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline({
        ["<CR>"] = {
          c = function(default)
            if cmp.visible() then
              return cmp.confirm({ select = true })
            end

            default()
          end,
        },
      }),
      sources = {
        { name = "buffer" },
      },
    })
  end,
  enabled = false,
}
