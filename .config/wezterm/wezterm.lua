-- Pull the wezterm api
local wezterm = require("wezterm")

-- Get the config
local config = wezterm.config_builder()

-- Set the font
config.font = wezterm.font({ family = "Hack Nerd Font Mono" })
config.font_size = 15
config.line_height = 1.2
config.adjust_window_size_when_changing_font_size = false

-- Define the way that fonts should be loaded
config.freetype_load_flags = "DEFAULT"

config.enable_tab_bar = false

-- Cool background effect
if wezterm.target_triple:find("darwin") then
	config.window_decorations = "RESIZE"
elseif wezterm.target_triple:find("linux") then
	config.window_decorations = "TITLE"
else
	config.window_decorations = "TITLE"
	config.default_prog = { "powershell" }
end

config.window_background_opacity = 0.75
config.macos_window_background_blur = 100

-- Window Padding
config.window_padding = {
	left = 1,
	right = 1,
	top = 0,
	bottom = 0,
}

-- Get cursor to match the color in is in
config.force_reverse_video_cursor = true

-- Keys
local act = wezterm.action
config.keys = {
	{
		key = "Backspace",
		mods = "CTRL",
		action = act.SendKey({ mods = "CTRL", key = "w" }),
	},
}

-- UI
config.window_close_confirmation = "NeverPrompt"
config.cursor_blink_rate = 500
config.win32_system_backdrop = "Acrylic"
config.enable_wayland = false

-- Theme
config.color_scheme = "MaterialDarker"

return config
