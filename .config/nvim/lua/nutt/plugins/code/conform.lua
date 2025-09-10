return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = "ConformInfo",
	---@type conform.setupOpts | {ignore_filetypes: table<string>}
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
		},
		format_on_save = {
			timeout_ms = 400,
			lsp_format = "fallback",
		},
	},
	keys = {
		{
			"<leader>cF",
			function()
				require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
			end,
			desc = "[F]ormat Buffer",
		},
	},
	opts_extend = { "ignore_filetypes" },
}
