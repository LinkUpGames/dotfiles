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

		local function configure(server)
			--- Get the capabilities for the current lsp running
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})

			if opts.setup[server] then
				local run = opts.setup[server]

				if run(server, server_opts) then
					return true
				end
			end
		end
	end,
}
