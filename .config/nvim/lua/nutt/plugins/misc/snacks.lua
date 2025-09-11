return {
	-- Snacks
	{
		lazy = false,
		priority = 1000,
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			dashboard = {
				enabled = true,
				page_gap = 1,
				preset = {
					header = [[
 _____                                                                                 _____ 
( ___ )                                                                               ( ___ )
 |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   | 
 |   | ███████╗ ██████╗ ██████╗██╗     ███████╗███████╗        █████╗     ██╗ ██████╗  |   | 
 |   | ██╔════╝██╔════╝██╔════╝██║     ██╔════╝██╔════╝       ██╔══██╗██╗███║██╔═████╗ |   | 
 |   | █████╗  ██║     ██║     ██║     █████╗  ███████╗       ╚██████║╚═╝╚██║██║██╔██║ |   | 
 |   | ██╔══╝  ██║     ██║     ██║     ██╔══╝  ╚════██║        ╚═══██║██╗ ██║████╔╝██║ |   | 
 |   | ███████╗╚██████╗╚██████╗███████╗███████╗███████║██╗     █████╔╝╚═╝ ██║╚██████╔╝ |   | 
 |   | ╚══════╝ ╚═════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝     ╚════╝     ╚═╝ ╚═════╝  |   | 
 |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___| 
(_____)                                                                               (_____)
Marcos Cevallos
Development
   ]],
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
			explorer = {
				enabled = true,
				replace_netrw = true,
			},
			indent = {
				indent = {
					only_scope = false,
					enabled = true,
					hl = { "SnacksIndent1", "SnacksIndent2", "SnacksIndent3", "SnacksIndent4" },
				},
				scope = {
					enabled = true,
				},
				chunk = {
					enabled = true,
					only_current = true,
				},
			},
			image = {
				enabled = true,
			},
			scroll = {
				enabled = true,
			},
			notifier = {
				enabled = true,
			},
			picker = {
				layout = {
					preset = function()
						return vim.o.columns >= 120 and "telescope" or "vertical"
					end,
				},
				formatters = {
					file = {
						filename_first = true,
					},
				},
				---@class snacks.picker.sources.Config
				sources = {
					files = {
						hidden = true,
					},
					explorer = {
						hidden = true,
						jump = {
							close = false,
						},
						win = {
							list = {
								keys = {
									["-"] = "explorer_up",
									["<c-c>"] = "",
								},
							},
						},
					},
				},
				icons = {
					ui = {
						hidden = "",
						live = "󰍉",
					},
				},
				win = {
					input = {
						keys = {
							["<c-h>"] = false,
							["<c-l>"] = false,
							["<c-j>"] = { "preview_scroll_left", mode = { "i", "n" } },
							["<c-k>"] = { "preview_scroll_right", mode = { "i", "n" } },
						},
					},
				},
			},
		},
		keys = {
			{
				"<leader>E",
				function()
					local snacks = require("snacks")
					snacks.picker.explorer()
				end,
				mode = { "n" },
				desc = "Open the file explorer",
			},
			-- Picker
			{
				"<leader>,",
				function()
					require("snacks").picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>/",
				function()
					require("snacks").picker.grep()
				end,
				desc = "Grep (Root Dir)",
			},
			{
				"<leader>:",
				function()
					require("snacks").picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader><space>",
				function()
					require("snacks").picker.files()
				end,
				desc = "Find Files (Root Dir)",
			},
			{
				"<leader>n",
				function()
					require("snacks").picker.notifications()
				end,
				desc = "Notification History",
			},
		},
	},

	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			local explorer = {
				sections = {
					lualine_a = {
						{
							function()
								return " Explorer"
							end,
							separator = {
								left = "",
								right = "",
							},
						},
					},
					lualine_b = { "branch" },
					lualine_z = {
						{
							function()
								return " " .. os.date("%I:%M %p")
							end,
							separator = {
								left = "",
								right = "",
							},
						},
					},
				},
				filetypes = {
					"snacks_picker_list",
				},
			}

			opts.extensions = opts.extensions or {}
			table.insert(opts.extensions, explorer)

			return opts
		end,
	},
}
