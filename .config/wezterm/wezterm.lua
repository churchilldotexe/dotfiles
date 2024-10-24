local wezterm = require("wezterm")
local gpus = wezterm.gui.enumerate_gpus()
return {
	color_scheme = "Kanagawa (Gogh)",
	enable_tab_bar = false,
	font_size = 16.0,
	-- font = wezterm.font("JetBrains Mono"),
	font = wezterm.font("ComicShannsMono Nerd Font"),

	-- window_background_opacity = 0.87,
	win32_system_backdrop = "Tabbed",
	window_decorations = "RESIZE",
	window_frame = {
		inactive_titlebar_bg = "#353535",
		active_titlebar_bg = "#2b2042",
		inactive_titlebar_fg = "#cccccc",
		active_titlebar_fg = "#ffffff",
		inactive_titlebar_border_bottom = "#2b2042",
		active_titlebar_border_bottom = "#2b2042",
		button_fg = "#cccccc",
		button_bg = "#2b2042",
		button_hover_fg = "#ffffff",
		button_hover_bg = "#3b3052",
	},

	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},

	-- GPU
	webgpu_preferred_adapter = gpus[1],
	front_end = "WebGpu",
	prefer_egl = true,

	-- background toggle
	wezterm.on("toggle-bg", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		if overrides.window_background_opacity == 1 then
			overrides.window_background_opacity = 0.85
		else
			overrides.window_background_opacity = 1
		end
		window:set_config_overrides(overrides)
	end),

	keys = {
		{
			key = "t",
			mods = "CTRL|SHIFT",
			action = wezterm.action.EmitEvent("toggle-bg"),
		},
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "'",
			mods = "CTRL",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}

-- [
--     {
--         "backend": "Vulkan",
--         "device": 9437,
--         "device_type": "DiscreteGpu",
--         "driver": "NVIDIA",
--         "driver_info": "560.35.03",
--         "name": "NVIDIA GeForce RTX 3070 Laptop GPU",
--         "vendor": 4318,
--     },
--     {
--         "backend": "Vulkan",
--         "device": 0,
--         "device_type": "Cpu",
--         "driver": "llvmpipe",
--         "driver_info": "Mesa 24.2.5 (git-3b9fcb7e4d) (LLVM 17.0.6)",
--         "name": "llvmpipe (LLVM 17.0.6, 256 bits)",
--         "vendor": 65541,
--     },
--     {
--         "backend": "Gl",
--         "device": 0,
--         "device_type": "Other",
--         "name": "NVIDIA GeForce RTX 3070 Laptop GPU/PCIe/SSE2",
--         "vendor": 4318,
--     },
-- ]
