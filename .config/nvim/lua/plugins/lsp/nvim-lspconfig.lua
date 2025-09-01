return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "Saghen/blink.cmp",
    "folke/snacks.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },
  },
  opts = function()
    local ret = {
      -- Options for vim.diagnostics.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
      },

      -- Enable inlay hints
      inlay_hints = {
        enabled = true,
        exclude = {}, -- Filetypes for which we don't want to enable hints for
      },

      -- Enable built in codelenes feature
      codelens = {
        enabled = false,
      },

      -- LSP Capabilities
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },

      -- Format Capabilities
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      -- LSP server settings
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
      },

      ---Any lsp server setup goes here
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {},
    }

    return ret
  end,
  config = function(_, opts)
    -- Lsp Attach CMD
    vim.api.nvim_create_autocmd("LSPAttach", {
      group = vim.api.nvim_create_augroup("lsp", { clear = true }),
      callback = function(event)
        -- Maps Available only for LSP
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Rename the variable under the cursor
        map("cr", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action
        map("cA", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

        -- Go to references
        map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

        -- Go to type definitions
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

        -- Diagnostics Signs
        if type(opts.diagnostics.signs) ~= "boolean" then
        end
      end,

      -- Get blink capabilities
    })
  end,
}
