return {
	"mason-org/mason.nvim",
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
	---@param opts MasonSettings | {ensure_installed: string[]}
	config = function(_, opts)
		local status, mason, mr

		-- Check Mason
		status, mason = pcall(require, "mason")

		if status then
			mason.setup(opts)
		end

		-- Check mason Registry
		status, mr = pcall(require, "mason-registry")
		if status then
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end
	end,
}
