local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
	{ key = "y", mods = "LEADER", action = act({ CopyTo = "Clipboard" }) }, -- 复制
	{ key = "p", mods = "LEADER", action = act({ PasteFrom = "Clipboard" }) }, -- 粘贴
	-- misc/useful --
	{ key = "F1", mods = "NONE", action = "ActivateCopyMode" }, -- copy-mode
	{ key = "f", mods = "LEADER", action = act.Search({ CaseInSensitiveString = "" }) },
	-- tabs:
	{ key = "t", mods = "LEADER", action = act.SpawnTab("DefaultDomain") },
	{ key = "N", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	--clear schrollback
	{ key = "c", mods = "LEADER", action = act.ClearScrollback("ScrollbackAndViewport") },
	-- panes:
	{
		key = "v",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = [[x]],
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	-------------------- key-tables
	-- resize font
	{
		key = "F",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_font",
			one_shot = false,
			timeout_milliseconds = 3000,
		}),
	},
	-- resize panes
	{
		key = "R",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
			timemout_miliseconds = 3000,
		}),
	},
}

local key_tables = {
	resize_font = {
		{ key = "k", action = act.IncreaseFontSize },
		{ key = "j", action = act.DecreaseFontSize },
		{ key = "r", action = act.ResetFontSize },
		{ key = "Escape", action = "PopKeyTable" },
	},

	resize_pane = {
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
	},
}

local wezterm = require("wezterm")
local act = wezterm.action

return {
	disable_default_key_bindings = true,
	hide_tab_bar_if_only_one_tab = false,
	show_new_tab_button_in_tab_bar = false,
	leader = { key = "z", mods = "CMD", timeout_milliseconds = 3000 },
	keys = keys,
	key_tables = key_tables,
}
