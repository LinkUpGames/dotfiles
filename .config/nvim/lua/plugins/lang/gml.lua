vim.filetype.add({
  extension = {
    gml = "gml",
  },
})

-- {
--     "stevearc/conform.nvim",
--     opts = {
--       formatters_by_ft = {
--         gml = { "prettier" },
--       },
--     },
--   },

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        gml = { "gobo" },
      },
      formatters = {
        gobo = {
          command = "C:\\Users\\mjcev\\.local\\bin\\gobo\\gobo.exe",
          args = { "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gml = {},
      },
      setup = {
        gml = function(_, opts)
          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")
          local util = require("lspconfig.util")

          local root_files = {
            ".gitignore",
          }

          if not configs.gml then
            configs.gml = {
              default_config = {
                cmd = { "C:\\Program Files\\GameMaker Studio 2\\GameMakerLanguageServer.exe", "--stdio" },

                autostart = true,

                filetypes = {
                  "gml",
                  "yyp",
                },

                single_file_support = true,

                root_dir = util.root_pattern(unpack(root_files)),

                settings = {},

                init_options = {
                  runtimeDirectory = "C:\\ProgramData\\GameMakerStudio2\\Cache\\runtimes\\runtime-2024.13.1.242",
                  runtimeVersion = "2024.8.0.216",
                  platforms = { "windows" },
                  languagePacks = {
                    "C:\\Program Files\\GameMaker Studio 2\\Plugins\\english\\english.csv",
                  },
                  language = "english",
                },

                commands = {},

                docs = {
                  description = [[]],
                },
              },
            }
          end

          lspconfig.gml.setup(opts)
        end,
      },
    },
  },
  {
    "JafarDakhan/vim-gml",
    ft = "gml",
    enabled = function()
      local sys = jit.os

      return sys == "Windows"
    end,
  },
}
