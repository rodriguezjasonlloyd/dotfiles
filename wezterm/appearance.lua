local wezterm = require("wezterm")

local config = {}

config.color_scheme = "ayu"
config.font = wezterm.font_with_fallback({
    { family = "Hack Nerd Font Mono", weight = "Regular" },
    { family = "MesloLGS Nerd Font Mono", weight = "Regular" },
    { family = "JetBrainsMono Nerd Font", weight = "Regular" },
    { family = "SauceCodePro Nerd Font Mono", weight = "Regular" },
})
config.font_size = 12.0
config.harfbuzz_features = { "calt = 0", "clig = 0", "liga = 0" }

return config
