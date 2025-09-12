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
		---@class Settings
		local settings = {
			--- Diagnostic Options
			---@type vim.diagnostic.Opts
			diagnostics = {
				underline = true,
				severity_sort = true,
				virtual_lines = {
					current_line = false,
					prefix = "●",
					severity = {
						min = vim.diagnostic.severity.ERROR,
					},
				},
				virtual_text = {
					max = vim.diagnostic.severity.WARN,
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
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

			---@type lspconfig.options
			servers = {
				lua_ls = {
					-- mason = false, -- set to false if you don't want this server to be installed with mason
					-- --@type LazykeysSpec[]
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

			---@type table<string, fun(server:string, opts: _.lspconfig.options): boolean?>
			setup = {},
		}

		return settings
	end,
	---@param opts Settings
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

					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Go to defintion
				map("gd", require("snacks").picker.lsp_definitions, "[G]oto [D]efinition")

				-- Go to implementation
				map("gi", require("snacks").picker.lsp_implementations, "[G]oto [I]mplementation")

				-- Go to declaration
				map("gD", require("snacks").picker.lsp_declarations, "[G]oto [D]eclaration")

				-- Go to type defintion
				map("gt", require("snacks").picker.lsp_type_definitions, "[G]oto [T]ype Defintion")

				-- Go to references
				map("gr", require("snacks").picker.lsp_references, "[G]oto [R]eferences")

				-- Get Client Capabilities
				---Get the capabilities of the client
				---@param client vim.lsp.Client
				---@param method vim.lsp.protocol.Method
				---@param bufnr integer some lsp support methods only in specific files
				local client_supports_method = function(client, method, bufnr)
					return client:supports_method(method, bufnr)
				end
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

		-- Fetch all servers available through mason-lspconfig
		local mlsp = require("mason-lspconfig")
		local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)

		-- Which one's don't start with mason
		local exclude_automatic_enable = {} ---@type string[]

		---Configure a server given it's name
		---@param server string
		---@return boolean status Was the server successfully configured?
		local function configure(server)
			--- Get the capabilities for the current lsp running
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})

			-- If we defined the setup for this server than run it
			if opts.setup[server] then
				local run = opts.setup[server]

				if run(server, server_opts) then
					return true
				end
			elseif opts.setup["*"] then
				local run = opts.setup["*"]

				if run(server, server_opts) then
					return true
				end
			end

			-- Configure language server
			vim.lsp.config(server, server_opts)

			-- manually enble if mason is false or if this is a server that cannot be installed with mason-lspconfig
			if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
				vim.lsp.enable(server)

				return true
			end

			return false
		end

		-- Run installation for both local and mason lsp configs
		local ensure_installed = {} ---@type string[]
		for server, server_opts in pairs(servers) do
			if server_opts then
				server_opts = server_opts == true and {} or server_opts

				if server_opts.enabled ~= false then
					local configured = configure(server)

					if configured then
						-- Don't rerun the configuration
						exclude_automatic_enable[#exclude_automatic_enable + 1] = server
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				else
					-- We don't want to run this
					exclude_automatic_enable[#exclude_automatic_enable + 1] = server
				end
			end
		end

		-- Mason Config
		local setup_config = {
			-- Make sure to add those that we want to install separately by mason
			ensure_installed = vim.tbl_deep_extend("force", ensure_installed, {}),
			automatic_enable = {
				exclude = exclude_automatic_enable,
			},
		}

		mlsp.setup(setup_config)
	end,
}
