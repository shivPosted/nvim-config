-- Pull in the wezterm API
local wezterm = require("wezterm")
-- These are the basic's for using wezterm.
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local mux = wezterm.mux
local act = wezterm.action

-- These are vars to put things in later (i dont use em all yet)
local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

-- This is for newer wezterm vertions to use the config builder
if wezterm.config_builder then
	config = wezterm.config_builder()
end
-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("MesloLGLDZ Nerd Font")
config.color_scheme = "Monokai Pro (Gogh)"
config.colors = {
	ansi = { "#7F442A", "#E52E2E", "#FC9867", "#FFE073", "#A277FF", "#a277ff", "#F7C195", "#F7C195" },
	brights = { "#7F442A", "#E52E2E", "#FC9867", "#FFE073", "#A277FF", "#a277ff", "#F7C195", "#F7C195" },
	-- ansi = {
	-- 	"#FC9867", -- Black
	-- 	"#FC9867", -- Red
	-- 	"#FC9867", -- Green
	-- 	"#FC9867", -- Yellow
	-- 	"#FC9867", -- Blue
	-- 	"#FC9867", -- Magenta
	-- 	"#FC9867", -- Cyan
	-- 	"#FC9867", -- White
	-- },
	-- brights = {
	-- 	"#FC9867", -- Bright Black
	-- 	"#FC9867", -- Bright Red
	-- 	"#FC9867", -- Bright Green
	-- 	"#FC9867", -- Bright Yellow
	-- 	"#FC9867", -- Bright Blue
	-- 	"#FC9867", -- Bright Magenta
	-- 	"#FC9867", -- Bright Cyan
	-- 	"#FC9867", -- Bright White
	-- },
}
config.font_size = 13
-- my coolnight colorscheme:
config.enable_tab_bar = false

config.window_decorations = "TITLE | RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- config.window_background_opacity = 0.9
-- config.disable_default_key_bindings = true

-- this adds the ability to use ctrl+v to paste the system clipboard
config.keys = { { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") } }

-- This is used to make my foreground (text, etc) brighter than my background
-- config.foreground_text_hsb = {
-- 	hue = 1.0,
-- 	saturation = 1.2,
-- 	brightness = 1.5,
-- }
--setting background image
config.background = {
	{
		source = { File = { path = "C:/Users/shivp/Pictures/terminalBG/terminal01.png" } },
		opacity = 1,
		width = "100%",
		hsb = { brightness = 0.05 },
	},
}

-- IMPORTANT: Sets WSL2 UBUNTU-22.04 as the defualt when opening Wezterm
config.default_domain = "WSL:Ubuntu-22.04"
-- and finally, return the configuration to wezterm
return config
