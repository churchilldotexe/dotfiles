local wezterm = require("wezterm")
-- local gpus = wezterm.gui.enumerate_gpus()
return {
	---
	------- themes and fonts ----
	---
	color_scheme = "Kanagawa (Gogh)",
	font_size = 15.0,
	-- font = wezterm.font("JetBrains Mono"),
	-- font = wezterm.font("ComicShannsMono Nerd Font"),
	font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" }),

	---
	------- Layout --------
	---
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
		-- border_left_width = "0.5cell",
		-- border_right_width = "0.5cell",
		-- border_bottom_height = "0.25cell",
		-- border_top_height = "0.25cell",
		-- border_left_color = "purple",
		-- border_right_color = "purple",
		-- border_bottom_color = "purple",
		-- border_top_color = "purple",
	},

	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},

	--
	------- Options and others -----
	--
	window_close_confirmation = "NeverPrompt",
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	-- window_decorations = "TITLE | RESIZE",

	-- GPU
	-- webgpu_preferred_adapter = gpus[1],
	-- front_end = "WebGpu",
	-- prefer_egl = true,

	---- KeyBindings -------
	---

	-- Decorations toggle
	wezterm.on("toggle-decor", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		if overrides.window_decorations == "RESIZE" then
			overrides.window_decorations = "TITLE | RESIZE"
		else
			overrides.window_decorations = "RESIZE"
		end
		window:set_config_overrides(overrides)
	end),

	wezterm.on("toggle-backdrop", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		if overrides.win32_system_backdrop == "Disable" then
			overrides.win32_system_backdrop = "Acrylic"
		else
			overrides.win32_system_backdrop = "Disable"
		end
		window:set_config_overrides(overrides)
	end),

	wezterm.on("toggle-opacity", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		if overrides.window_background_opacity == 1 then
			overrides.window_background_opacity = 0.75
		else
			overrides.window_background_opacity = 1
		end
		window:set_config_overrides(overrides)
	end),

	leader = { key = ";", mods = "CTRL", timeout_milliseconds = 1000 },

	keys = {
		{
			key = "d",
			mods = "LEADER",
			action = wezterm.action.EmitEvent("toggle-decor"),
		},
		{
			key = "b",
			mods = "LEADER",
			action = wezterm.action.EmitEvent("toggle-backdrop"),
		},
		{
			key = "o",
			mods = "LEADER",
			action = wezterm.action.EmitEvent("toggle-opacity"),
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
