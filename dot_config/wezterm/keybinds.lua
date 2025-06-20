local wezterm = require("wezterm")

local config = {}

config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
    { mods = "LEADER", key = "f", action = wezterm.action.ToggleFullScreen },
    { mods = "LEADER", key = "c", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
    { mods = "LEADER", key = "b", action = wezterm.action.ActivateTabRelative(-1) },
    { mods = "LEADER", key = "n", action = wezterm.action.ActivateTabRelative(1) },
    { mods = "LEADER", key = "\\", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "s", action = wezterm.action.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },
    { mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
    { mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
    { mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
    { mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
    { mods = "ALT", key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 2 }) },
    { mods = "ALT", key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 2 }) },
    { mods = "ALT", key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 2 }) },
    { mods = "ALT", key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 2 }) },
}

return config
