local wezterm = require("wezterm")
local act = wezterm.action

return {
	-- window_decorations = "RESIZE",
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 14.0,
	scrollback_lines = 100000,
	force_reverse_video_cursor = true,
	colors = {
		foreground = "#dcd7ba",
		background = "#1f1f28",

		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		-- split = "#16161d", -- kanagawa theme color
		split = "#333333",

		ansi = {
			"#090618",
			"#c34043",
			"#76946a",
			"#c0a36e",
			"#7e9cd8",
			"#957fb8",
			"#6a9589",
			"#c8c093",
		},
		brights = {
			"#727169",
			"#e82424",
			"#98bb6c",
			"#e6c384",
			"#7fb4ca",
			"#938aa9",
			"#7aa89f",
			"#dcd7ba",
		},
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	},
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	pane_focus_follows_mouse = true,
	debug_key_events = true,

	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.6,
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
		-- open link when CMD is pressed
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "SUPER",
			action = act.OpenLinkAtMouseCursor,
		},
		-- automatically copy selected text, middle click will paste because of default assignment
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act.CompleteSelection("Clipboard"),
		},
		-- disable mouse scrolling
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "NONE",
			action = act.DisableDefaultAssignment,
		},
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "NONE",
			action = act.DisableDefaultAssignment,
		},
	},

	-- some keymaps (with defaults in comment above)
	keys = {
		{
			key = "LeftArrow",
			mods = "SUPER|SHIFT",
			action = act.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "DownArrow",
			mods = "SUPER|SHIFT",
			action = act.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "UpArrow",
			mods = "SUPER|SHIFT",
			action = act.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "RightArrow",
			mods = "SUPER|SHIFT",
			action = act.AdjustPaneSize({ "Right", 5 }),
		},
		-- disable default SHIFT-Up & SHIFT-Down
		-- { key = "UpArrow", mods = "SHIFT", action = act.DisableDefaultAssignment },
		-- { key = "DownArrow", mods = "SHIFT", action = act.DisableDefaultAssignment },
		-- NO DEFAULT
		{ key = "PageUp", mods = "SUPER|SHIFT", action = act.ScrollByLine(-1) },
		-- NO DEFAULT
		{ key = "PageDown", mods = "SUPER|SHIFT", action = act.ScrollByLine(1) },
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
		{
			key = "d",
			mods = "SUPER|SHIFT",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		-- CTRL+SHIFT+ALT	%	SplitHorizontal={domain="CurrentPaneDomain"}
		{
			key = "d",
			mods = "SUPER",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- CTRL+SHIFT	P	PaneSelect
		{ key = "P", mods = "SUPER|SHIFT", action = act.PaneSelect },
		-- CTRL+SHIFT	LeftArrow	ActivatePaneDirection="Left"
		{
			key = "LeftArrow",
			mods = "SUPER",
			action = act.ActivatePaneDirection("Left"),
		},
		-- CTRL+SHIFT	RightArrow	ActivatePaneDirection="Right"
		{
			key = "RightArrow",
			mods = "SUPER",
			action = act.ActivatePaneDirection("Right"),
		},
		-- CTRL+SHIFT	UpArrow	ActivatePaneDirection="Up"
		{
			key = "UpArrow",
			mods = "SUPER",
			action = act.ActivatePaneDirection("Up"),
		},
		-- CTRL+SHIFT	DownArrow	ActivatePaneDirection="Down"
		{
			key = "DownArrow",
			mods = "SUPER",
			action = act.ActivatePaneDirection("Down"),
		},
		-- CTRL+SHIFT	Z	TogglePaneZoomState
		{ key = "Enter", mods = "SUPER|SHIFT", action = act.TogglePaneZoomState },
	},
}
