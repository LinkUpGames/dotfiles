-- This is how we define a custom lsp. We will use this as our basis for creating the lsp and folowing the tutorial
return {}
--
-- return {
--   "neovim/nvim-lspconfig",
--   opts = {
--     servers = {
--       custom = {},
--     },
--     setup = {
--       custom = function(_, opts)
--         local lspconfig = require("lspconfig")
--         local configs = require("lspconfig.configs")
--         local util = require("lspconfig.util")
--
--         local root_files = {
--           ".git",
--           "README.md",
--         }
--
--         if not configs.custom then
--           configs.custom = {
--             default_config = {
--               cmd = { "/home/mcb0ss/development/doodles/Go/lsp/main" },
--
--               filetypes = {
--                 "markdown",
--               },
--
--               single_file_support = true,
--
--               root_dir = util.root_pattern(unpack(root_files)),
--
--               settings = {},
--
--               commands = {},
--
--               docs = {
--                 description = [[]],
--               },
--             },
--           }
--         end
--
--         lspconfig.custom.setup(opts)
--       end,
--     },
--   },
-- }
