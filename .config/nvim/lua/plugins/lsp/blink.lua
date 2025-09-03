return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  -- build = "cargo build --release",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
    },
    {
      "saghen/blink.compat",
      optional = true,
      opts = {},
    },
  },
  opts = {},
}
