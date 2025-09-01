return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  build = "cargo build --release",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    {
      "saghen/blink.compat",
      optional = true,
      opts = {},
    },
  },
  opts = {
    snippets = { preset = "luasnip" },
  },
}
