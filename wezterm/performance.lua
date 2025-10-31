local wezterm = require("wezterm")
local utility = require("utility")

local config = {}

config.scrollback_lines = 5000
config.front_end = "WebGpu"
config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = wezterm.action.CompleteSelection("Clipboard"),
    },
}

if utility.os() == "windows" then
    config.default_prog = { "pwsh" }
end

return config
