local group = vim.api.nvim_create_augroup("lualine-settings", { clear = true })

---Update the parameters for toggle_buffer
---@param lualine table
local function toggle_buffer(lualine)
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })
	local tabs = vim.api.nvim_list_tabpages()

	if #buffers <= 1 and #tabs <= 1 then -- Hide
		vim.o.showtabline = 1
		lualine.hide({
			place = { "tabline" },
			unhide = false,
		})
	else -- Show
		vim.o.showtabline = 2
		lualine.hide({
			place = { "tabline" },
			unhide = true,
		})
	end
end

-- Show the tabline when an buffer is added, deleted
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "VimEnter", "ColorScheme", "TabNew", "TabClosed" }, {
	group = group,
	callback = function()
		vim.defer_fn(function()
			local has_lualine, lualine = pcall(require, "lualine")

			if has_lualine then
				toggle_buffer(lualine)
			end
		end, 5)
	end,
})

-- Make sure that the status line respects the width of the instance
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = group,
	callback = function()
		local has_lualine, lualine = pcall(require, "lualine")

		if has_lualine then
			local opts = lualine.get_config()

			if opts.tabline and opts.tabline.lualine_a then
				for _, component in ipairs(opts.tabline.lualine_a) do
					if type(component) == "table" and component[1] == "buffers" then
						component.max_length = vim.o.columns * (9 / 10)
					end
				end
			end

			lualine.setup(opts)
			toggle_buffer(lualine)
		end
	end,
})

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			component_separators = {
				left = "",
				right = "",
			},
			section_separators = {
				left = "",
				right = "",
			},
			disabled_filetypes = {
				statusline = {
					"snacks_dashboard",
				},
			},
		},
	},
}
