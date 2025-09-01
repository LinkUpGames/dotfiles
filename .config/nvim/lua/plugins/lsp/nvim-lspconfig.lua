return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile", "BufWritePre" },
  dependencies = {
    "mason-org/mason.nvim",
    "Saghen/blink.cmp",
    "mason-org/mason-lspconfig.nvim",
  },
  opts = function()
    ---@class PluginLspOpts
    local ret = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "● ",
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

      inlay_hints = {
        enabled = true,
        exclude = {},
      },

      codelens = {
        enabled = false,
      },

      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },

      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      ---@type lspconfig.options
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = { enable = true },
              completion = { callSnippet = "Replace" },
              doc = { privateName = { "^_" } },
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

      setup = {},
    }
    return ret
  end,
  ---@param opts PluginLspOpts
  config = function(_, opts)
    -- LspAttach autocmd
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local buffer = event.buf

        -- keymaps
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = buffer, desc = "LSP: " .. desc })
        end

        map("cr", vim.lsp.buf.rename, "[R]e[n]ame", { "n", "x" })
        map("cA", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

        -- diagnostic signs
        if type(opts.diagnostics.signs) ~= "boolean" then
          for severity, icon in pairs(opts.diagnostics.signs.text) do
            local severity_names = {
              [vim.diagnostic.severity.ERROR] = "Error",
              [vim.diagnostic.severity.WARN] = "Warn",
              [vim.diagnostic.severity.INFO] = "Info",
              [vim.diagnostic.severity.HINT] = "Hint",
            }

            local name = severity_names[severity]

            if name then
              vim.fn.sign_define("DiagnosticSign" .. name, {
                text = icon,
                texthl = "DiagnosticSign" .. name,
                numhl = "",
              })
            end
          end
        end

        -- inlay hints
        if
          opts.inlay_hints.enabled
          and client
          and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
          and vim.api.nvim_buf_is_valid(buffer)
          and vim.bo[buffer].buftype == ""
          and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end

        -- code lens
        if
          opts.codelens.enabled
          and vim.lsp.codelens
          and client
          and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens, buffer)
        then
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd(
            { "BufEnter", "CursorHold", "InsertLeave" },
            { buffer = buffer, callback = vim.lsp.codelens.refresh }
          )
        end

        -- virtual text diagnostics prefix as icons
        if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
          opts.diagnostics.virtual_text.prefix = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.HINT] = " ",
              [vim.diagnostic.severity.INFO] = " ",
            }

            return icons[diagnostic.severity] or "●"
          end
        end

        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
      end,
    })

    -- capabilities
    local has_blink, blink = pcall(require, "blink.cmp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_blink and blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    -- mason integration
    local have_mason, mlsp = pcall(require, "mason-lspconfig")
    local all_mslp_servers = {}
    if have_mason then
      all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
    end

    local configure = function(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, opts.servers[server] or {})

      -- Setup Overrides
      if opts.setup[server] and opts.setup[server](server, server_opts) then
        return true
      elseif opts.setup["*"] and opts.setup["*"](server, server_opts) then
        return true
      end

      -- Only enable servers not managed by mason
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
        return true
      end
      return false
    end

    local ensure_installed, exclude_automatic_enable = {}, {}
    for server, server_opts in pairs(opts.servers) do
      server_opts = server_opts == true and {} or server_opts

      if server_opts.enabled ~= false then
        if configure(server) then
          table.insert(exclude_automatic_enable, server)
        else
          table.insert(ensure_installed, server)
        end
      else
        table.insert(exclude_automatic_enable, server)
      end
    end

    if have_mason then
      local setup_config = {
        ensure_installed = ensure_installed,
        automatic_enable = {
          exclude = exclude_automatic_enable,
        },
      }

      mlsp.setup(setup_config)
    end
  end,
}
