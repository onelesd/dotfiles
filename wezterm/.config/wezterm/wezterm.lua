local wezterm = require("wezterm")
local act = wezterm.action

return {
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 16.0,
	scrollback_lines = 100000,
	-- color_scheme = "nord",
	color_scheme = "kanagawabones",
	colors = {
		split = "#000000",
	},
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	pane_focus_follows_mouse = true,
	debug_key_events = true,

	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.7,
	},

	window_background_opacity = 1.0,

	hyperlink_rules = {
		-- turn neovim packages into hyperlinks
		{
			regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
			format = "https://www.github.com/$1/$3",
		},
	},

	mouse_bindings = {
		-- disable default no-mod click opening of hyperlinks
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act.DisableDefaultAssignment,
		},
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "SUPER",
			action = act.OpenLinkAtMouseCursor,
		},
	},

	-- some keymaps (with defaults in comment above)
	keys = {
		-- disable default SHIFT-Up & SHIFT-Down
		-- { key = "UpArrow", mods = "SHIFT", action = act.DisableDefaultAssignment },
		-- { key = "DownArrow", mods = "SHIFT", action = act.DisableDefaultAssignment },
		-- NO DEFAULT
		{ key = "UpArrow", mods = "SUPER", action = act.ScrollByLine(-1) },
		-- NO DEFAULT
		{ key = "DownArrow", mods = "SUPER", action = act.ScrollByLine(1) },
		-- NO DEFAULT
		{ key = "r", mods = "SUPER|SHIFT", action = act.RotatePanes("Clockwise") },
		-- NO DEFAULT
		{ key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
		-- NO DEFAULT
		{ key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
		-- SHIFT	PageUp	ScrollByPage=-1
		{ key = "PageUp", mods = "SUPER", action = act.ScrollByPage(-1) },
		-- SHIFT	PageDown	ScrollByPage=1
		{ key = "PageDown", mods = "SUPER", action = act.ScrollByPage(1) },
		-- CTRL+SHIFT+ALT	"	SplitVertical={domain="CurrentPaneDomain"}
		{ key = "d", mods = "SUPER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- CTRL+SHIFT+ALT	%	SplitHorizontal={domain="CurrentPaneDomain"}
		{ key = "d", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		-- CTRL+SHIFT	P	PaneSelect
		{ key = "P", mods = "SUPER|SHIFT", action = act.PaneSelect },
		-- CTRL+SHIFT	LeftArrow	ActivatePaneDirection="Left"
		{ key = "LeftArrow", mods = "SUPER|SHIFT", action = act.ActivatePaneDirection("Left") },
		-- CTRL+SHIFT	RightArrow	ActivatePaneDirection="Right"
		{ key = "RightArrow", mods = "SUPER|SHIFT", action = act.ActivatePaneDirection("Right") },
		-- CTRL+SHIFT	UpArrow	ActivatePaneDirection="Up"
		{ key = "UpArrow", mods = "SUPER|SHIFT", action = act.ActivatePaneDirection("Up") },
		-- CTRL+SHIFT	DownArrow	ActivatePaneDirection="Down"
		{ key = "DownArrow", mods = "SUPER|SHIFT", action = act.ActivatePaneDirection("Down") },
		-- CTRL+SHIFT	Z	TogglePaneZoomState
		{ key = "Enter", mods = "SUPER|SHIFT", action = act.TogglePaneZoomState },
	},
}
