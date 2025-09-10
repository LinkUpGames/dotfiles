return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile", "BufWritePre" },
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"Saghen/blink.cmp",
	},
	opts = function()
		---@class Settings
		local settings = {

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
		-- Setup keymaps

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
