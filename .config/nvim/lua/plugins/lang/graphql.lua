return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        graphql = {
          root_dir = function(file_name, _)
            local lspconfig = require("lspconfig")

            local root = lspconfig.util.find_git_ancestor(file_name)

            return root
          end,
        },
      },
    },
  },
}
