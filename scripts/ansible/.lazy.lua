vim.api.nvim_create_autocmd("FileType", {
	pattern = { "yaml" },
	callback = function()
		vim.bo.filetype = "yaml.ansible"
	end,
})

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			yaml = { lsp_format = "prefer" },
		},
	},
}
