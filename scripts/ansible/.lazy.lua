-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "yaml" },
-- 	callback = function()
-- 		vim.bo.filetype = "yaml.ansible"
-- 	end,
-- })

return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				yaml = { lsp_format = "prefer" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			---@module "nutt.plugins.code.nvim-lspconfig"
			---@type table<string, LspServerConfig>
			servers = {
				yamlls = {
					filetypes = { "yaml", "yaml.ansible" },
				},
				ansiblels = {
					filetypes = { "yaml", "yaml.ansible" },
				},
			},
		},
	},
}
