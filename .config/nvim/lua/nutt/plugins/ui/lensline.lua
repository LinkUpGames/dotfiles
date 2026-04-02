if true then
  return {}
end

---@module "lazy"
---@type LazySpec
return {
  "oribarilan/lensline.nvim",
  branch = "release/2.x",
  event = "LspAttach",
  opts = {
    profiles = {
      {
        name = "minimal",
        providers = {
          {
            name = "usages",
            enabled = true,
            shown_zero = false,
            include = {
              "refs",
            },
          },
        },
        style = {
          render = "all",
        },
      },
    },
  },
  opts_extend = {
    "profiles",
  },
}
