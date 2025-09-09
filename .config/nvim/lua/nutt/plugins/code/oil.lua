return {
	{ -- cmd = "Oil",
		lazy = false,
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = false,
			keymaps = {
				["q"] = {
					function()
						require("oil").discard_all_changes()
						require("oil").close()
					end,
					mode = { "n" },
				},
				["-"] = { "actions.parent", mode = { "n" } },
				["_"] = { "actions.open_cwd", mode = { "n" } },
				["<CR>"] = { "actions.select", mode = { "n" } },
				["+"] = {
					"actions.preview",
					mode = { "n" },
				},
				["K"] = { "actions.preview_scroll_up", mode = { "n" } },
				["J"] = { "actions.preview_scroll_down", mode = { "n" } },
				["<C-b>"] = { "actions.preview_scroll_up", mode = { "n" } },
				["<C-f>"] = { "actions.preview_scroll_down", mode = { "n" } },
				-- Remove this so that it doesn't activate
				["?"] = "",
			},
			view_options = {
				show_hidden = true,
				natural_order = false,
			},
			use_default_keymaps = false,
		},
		keys = {
			{
				"<leader>e",
				function()
					local oil = require("oil")

					oil.toggle_float()
				end,
				mode = { "n" },
				desc = "Open current directory",
			},
		},
	},
}
