return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              hint = { enable = true, setType = true },
            },
          },
        },
      },
    },
  },
}
