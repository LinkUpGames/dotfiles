return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile", "BufWritePre" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "folke/snacks.nvim",
    "Saghen/blink.cmp",
  },
  opts = function()
    ---@class LspConfigOpts
    local settings = {
      --- Diagnostic Options
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        severity_sort = true,
        float = {
          border = "rounded",
        },
        -- virtual_lines = {
        --   current_line = false,
        --   prefix = "● ",
        --   severity = {
        --     min = vim.diagnostic.severity.ERROR,
        --   },
        -- },
        -- virtual_text = {
        --   severity = {
        --     max = vim.diagnostic.severity.WARN,
        --   },
        --   spacing = 4,
        --   source = "if_many",
        --   prefix = "● ",
        -- },
        signs = {
          numhl = {
            [vim.diagnostic.severity.WARN] = "WarningMsg",
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
          },
          text = {
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        },
      },

      -- Inlay Hints
      inlay_hints = {
        enabled = true,
        exclude = { "vue" },
      },

      -- Codelens
      codelens = {
        enabled = false,
      },

      -- Format
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      -- Global capabilities
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },

      ---@class LspServerConfig: vim.lsp.Config
      ---@field enabled? boolean
      ---@field mason? boolean

      ---@type table<string, LspServerConfig>
      servers = {
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- ---@type LazyKeysSpec[]
          -- keys = {}
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

      ---@type table<string, fun(server:string, opts: vim.lsp.Config): boolean?>
      setup = {},
    }

    return settings
  end,
  ---@param opts LspConfigOpts
  config = function(_, opts)
    -- Create autocmd
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        -- Key maps
        ---map a key for lsp only keybinds
        ---@param keys any
        ---@param func any
        ---@param desc any
        ---@param mode any
        local map = function(keys, func, desc, mode)
          mode = mode or "n"

          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc, remap = true })
        end

        -- Go to defintion
        map("gld", require("snacks").picker.lsp_definitions, "[G]oto [L]sp [D]efinition")

        -- Go to implementation
        map("glI", require("snacks").picker.lsp_implementations, "[G]oto [L]sp [I]mplementation")

        -- Go to declaration
        map("glD", require("snacks").picker.lsp_declarations, "[G]oto [L]sp [D]eclaration")

        -- Go to type defintion
        map("glt", require("snacks").picker.lsp_type_definitions, "[G]oto [L]sp [T]ype Defintion")

        -- Go to references
        map("glr", require("snacks").picker.lsp_references, "[G]oto [L]sp [R]eferences")

        -- Open Code Actions
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

        -- Get Client Capabilities
        ---Get the capabilities of the client
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr integer some lsp support methods only in specific files
        local client_supports_method = function(client, method, bufnr)
          return client:supports_method(method, bufnr)
        end

        local buf = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client then
          -- Inlay Hints
          if opts.inlay_hints.enabled and client_supports_method(client, "textDocument/inlayHint", buf) then
            if
              vim.api.nvim_buf_is_valid(buf)
              and vim.bo[buf].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buf].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            end
          end

          -- Code lens
          if
            opts.codelens.enabled
            and vim.lsp.codelens
            and client_supports_method(client, "textDocument/codeLens", buf)
          then
            vim.lsp.codelens.refresh()

            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = buf,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end

        -- Diagnostic Config
        if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
          opts.diagnostics.virtual_text.prefix = function(diagnostic)
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

              return "● "
            end
          end
        end

        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
      end,
    })

    local servers = opts.servers
    local blink = require("blink.cmp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities() or {},
      blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    servers["*"] = vim.tbl_deep_extend("force", servers["*"] or {}, {
      capabilities = capabilities,
    })

    -- Fetch all servers available through mason-lspconfig
    local mlsp = require("mason-lspconfig")
    local mason_all = vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)

    -- Exclude from mason
    local mason_exclude = {} ---@type string[]

    ---Configure a server given it's name
    ---@param server string
    ---@return boolean status Was the server successfully configured?
    local function configure(server)
      if server == "*" then
        return false
      end

      local sopts = opts.servers[server]
      sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts

      if sopts.enabled == false then
        mason_exclude[#mason_exclude + 1] = server

        return false
      end

      local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
      local setup = opts.setup[server] or opts.setup["*"]

      if setup and setup(server, sopts) then
        mason_exclude[#mason_exclude + 1] = server
      else
        vim.lsp.config(server, sopts) -- configure the server

        if not use_mason then
          vim.lsp.enable(server)
        end
      end

      return use_mason
    end

    -- Run installation for both local and mason lsp configs
    local install = vim.tbl_filter(configure, vim.tbl_keys(servers))
    mlsp.setup({
      ensure_installed = install,
      automatic_enable = { exclude = mason_exclude },
    })
  end,
}
