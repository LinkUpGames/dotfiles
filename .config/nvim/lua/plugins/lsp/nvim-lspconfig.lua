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
    ---@class PluginLspOpts
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
  ---@param opts PluginLspOpts
  config = function(_, opts)
    -- Lsp Attach CMD
    vim.api.nvim_create_autocmd("LSPAttach", {
      group = vim.api.nvim_create_augroup("lsp", { clear = true }),
      callback = function(event)
        -- Check for lsp support
        ---This function helps resolve whether the lsp client supports capabilities
        ---@param c vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer som lsp support methods only in specific files
        local client_supports_method = function(c, method, bufnr)
          return c:supports_method(method, bufnr)
        end

        ---Keyboard mappings
        ---@param keys string
        ---@param func function
        ---@param desc string
        ---@param mode? table|string
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Get client
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local buffer = event.buf

        -- Mappings
        -- Rename the variable under the cursor
        map("cr", vim.lsp.buf.rename, "[R]e[n]ame", { "n", "x" })

        -- Execute a code action
        map("cA", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

        -- Go to references
        map("gr", vim.lsp.buf.references, "[G]oto [R]eferences", { "n", "x" })

        -- Go to type definitions
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition", { "n", "x" })

        -- Go to implementation
        map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation", { "n", "x" })

        -- Diagnostics Signs
        if type(opts.diagnostics.signs) ~= "boolean" then
          for severity, icon in pairs(opts.diagnostics.signs) do
            local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)

            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
          end
        end

        -- Inlay Hints
        if opts.inlay_hints.enabled then
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint) then
            if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end
        end

        -- Code lens
        if opts.codelens.enabled and vim.lsp.codelens then
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_codeLens, buffer) then
            vim.lsp.codelens.refresh()

            vim.api.nvim_create_autocmd(
              { "BufEnter", "CursorHold", "InsertLeave" },
              { buffer = buffer, callback = vim.lsp.codelens.refresh }
            )
          end
        end

        -- Virtual Text Diagnostics
        if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
          opts.diagnostics.virtual_text.prefix = "●"
            or function(diagnostic)
              local icons = {
                Error = " ",
                Warn = " ",
                Hint = " ",
                Info = " ",
              }

              for d, icon in pairs(icons) do
                if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                  return icon
                end
              end
            end
        end
        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

        -- Get blink capabilities
        local servers = opts.servers
        local has_blink, blink = pcall(require, "blink.cmp")
        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          has_blink and blink.get_lsp_capabilities() or {},
          opts.capabilities or {}
        )

        -- Get all servers that are available through mason
        local have_mason, mlsp = pcall(require, "mason-lspconfig")
        local all_mslp_servers = {}
        local exclude_automatic_enable = {} ---@type string[]

        -- Get mappings from mason
        if have_mason then
          all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
        end

        local configure = function(server)
          local server_opts = vim.tbl_deep_extend("force", {
            capabilities = vim.deepcopy(capabilities),
          }, servers[server] or {})

          if opts.setup[server] then
            if opts.setup[server](server, server_opts) then
              return true
            end
          elseif opts.setup["*"] then
            if opts.setup["*"](server, server_opts) then
              return true
            end
          end

          -- Configure server
          vim.lsp.config(server, server_opts)

          -- Manually enable if mason = false
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            vim.lsp.enable(server)
            return true
          end

          return false
        end

        -- Add that we want to automatically install the following
        local ensure_installed = {} ---@type string[]
        for server, server_opts in pairs(servers) do
          if server_opts then
            server_opts = server_opts == true and {} or server_opts

            if server_opts.enabled ~= false then
              -- Run manual setup if mason = false or if this is a server that cannot be installed
              if configure(server) then
                exclude_automatic_enable[#exclude_automatic_enable + 1] = server
              else
                ensure_installed[#ensure_installed + 1] = server
              end
            else
              exclude_automatic_enable[#exclude_automatic_enable + 1] = server
            end
          end
        end

        if have_mason then
          local setup_config = {
            ensure_installed = vim.tbl_deep_extend("force", ensure_installed),
          }

          setup_config.automatic_enable = {
            exclude = exclude_automatic_enable,
          }

          mlsp.setup(setup_config)
        end
      end,
    })
  end,
}
