local wezterm = require("wezterm")
local bgOpacity = 0.90
local act = wezterm.action

wezterm.on("update-status", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if window:is_focused() then
		overrides.color_scheme = "Kanagawa (Gogh)"
		overrides.text_background_opacity = 1
		overrides.font_size = 15
	else
		-- overrides.color_scheme = "Broadcast (Gogh)"
		overrides.text_background_opacity = 0
		overrides.font_size = 0
	end
	window:set_config_overrides(overrides)
end)

return {
	---
	------- themes and fonts ----
	---
	color_scheme = "Kanagawa (Gogh)",
	font_size = 15,
	-- font = wezterm.font("JetBrains Mono"),
	-- font = wezterm.font("ComicShannsMono Nerd Font"),
	-- font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" }),
	-- font = wezterm.font("Fira Code Script", { weight = "Medium" }),
	font = wezterm.font("FantasqueSansM Nerd Font", { weight = "Regular" }),
	-- font = wezterm.font("ZedMono Nerd Font", { weight = "Regular", stretch = "Normal" }),
	-- cell_width = 1.01,
	-- xcursor_theme = "Adwaita",

	---
	------- Layout --------
	---
	-- win32_system_backdrop = backdrop,
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},
	use_fancy_tab_bar = false,
	window_background_opacity = bgOpacity,
	window_frame = {
		inactive_titlebar_bg = "#000000",
		active_titlebar_bg = "#2b2042",
		inactive_titlebar_fg = "#000000",
		active_titlebar_fg = "#ffffff",
		inactive_titlebar_border_bottom = "#000000",
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

	------- Options and others -----

	-- enable_wayland = false,
	term = "wezterm",
	max_fps = 240,
	window_close_confirmation = "NeverPrompt",
	enable_tab_bar = false,
	window_decorations = "RESIZE | TITLE",

	-- window_decorations = "TITLE | RESIZE",

	-- GPU
	-- front_end = "WebGpu",
	-- prefer_egl = true,
	-- webgpu_preferred_adapter = gpus[1],
	-- webgpu_power_preference = "HighPerformance",

	---- KeyBindings -------

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

	--[[
	wezterm.on("toggle-backdrop", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		if overrides.win32_system_backdrop == "Disable" then
			overrides.win32_system_backdrop = backdrop
		else
			overrides.win32_system_backdrop = "Disable"
		end
		window:set_config_overrides(overrides)
	end),
--]]
	wezterm.on("toggle-opacity", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		if overrides.window_background_opacity == bgOpacity then
			overrides.window_background_opacity = bgOpacity
		else
			overrides.window_background_opacity = bgOpacity
		end
		window:set_config_overrides(overrides)
	end),

	leader = { key = ";", mods = "CTRL", timeout_milliseconds = 1000 },

	keys = {
		{
			key = "d",
			mods = "LEADER",
			action = act.EmitEvent("toggle-decor"),
		},
		--[[
		{
			key = "b",
			mods = "LEADER",
			action = act.EmitEvent("toggle-backdrop"),
		},
			--]]
		{
			key = "g",
			mods = "LEADER",
			action = act.EmitEvent("toggle-opacity"),
		},
		{
			key = "f",
			mods = "LEADER",
			action = act.ToggleFullScreen,
		},
		{
			key = "'",
			mods = "LEADER",
			action = act.ClearScrollback("ScrollbackAndViewport"),
		},

		-- workspace --
		{
			key = "y",
			mods = "LEADER",
			action = act.SwitchToWorkspace({
				name = "default",
			}),
		},
		-- Switch to a monitoring workspace, which will have `top` launched into it
		{
			key = "u",
			mods = "LEADER",
			action = act.SwitchToWorkspace({
				name = "monitoring",
			}),
		},
		-- Create a new workspace with a random name and switch to it
		{ key = "i", mods = "LEADER", action = act.SwitchToWorkspace },
		-- Show the launcher in fuzzy selection mode and have it list all workspaces
		-- and allow activating one.
		{
			key = "o",
			mods = "LEADER",
			action = act.ShowLauncherArgs({
				flags = "FUZZY|WORKSPACES",
			}),
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.OpenLinkAtMouseCursor,
		},
	},
}
