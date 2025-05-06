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
        gobo = function()
          local sys = jit.os

          local command = os.getenv("HOME") .. "/.local/bin/gobo"

          if sys == "Windows" then
            command = "C:\\Users\\mjcev\\.local\\bin\\gobo.exe"
          end

          return {
            command = command,
            args = { "$FILENAME" },
            stdin = false,
          }
        end,
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
          local sys = jit.os

          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")
          local util = require("lspconfig.util")

          local root_files = {
            ".gitignore",
          }

          -- System Commands
          local cmd = {
            (os.getenv("HOME") or "") .. "/AppImage/GameMaker/data/opt/GameMaker-Beta/x86_64/GameMakerLanguageServer",
            "--stdio",
          }

          local runtime_version = "runtime-2024.1400.0.802" -- Get the right runtime to get the latest features

          local runtime = (os.getenv("HOME") or "")
            .. "/.local/share/GameMakerStudio2-Beta/Cache/runtimes/"
            .. runtime_version

          local language = {
            (os.getenv("HOME") or "")
              .. "/AppImage/GameMaker/data/opt/GameMaker-Beta/x86_64/Plugins/english/english.csv",
          }

          if sys == "Windows" then
            cmd = { "C:\\Program Files\\GameMaker Studio 2\\GameMakerLanguageServer.exe", "--stdio" }
            runtime = "C:\\ProgramData\\GameMakerStudio2\\Cache\\runtimes\\" .. runtime_version
            language = { "C:\\Program Files\\GameMaker Studio 2\\Plugins\\english\\english.csv" }
          end

          if not configs.gml then
            configs.gml = {
              default_config = {
                cmd = cmd,

                autostart = true,

                filetypes = {
                  "gml",
                  "yyp",
                },

                single_file_support = true,

                root_dir = util.root_pattern(unpack(root_files)),

                settings = {},

                init_options = {
                  runtimeDirectory = runtime,
                  runtimeVersion = "2024.8.0.216",
                  platforms = { "windows", "ubuntu" },
                  languagePacks = language,
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
  },
}
