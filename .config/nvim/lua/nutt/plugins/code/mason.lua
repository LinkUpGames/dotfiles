return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
	},
	cmd = "Mason",
	build = ":MasonUpdate",
	keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	opts_extend = { "ensure_installed" },
	opts = {
		ensure_installed = {
			"stylua",
			"shfmt",
		},
	},
	config = function() end,
}
