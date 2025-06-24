local wezterm = require("wezterm")

local config = {}

config.color_scheme = "nord"
config.font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font", weight = "Bold" },
    { family = "MesloLGS Nerd Font Mono", weight = "Bold" },
    { family = "Hack Nerd Font Mono", weight = "Bold" },
    { family = "SauceCodePro Nerd Font Mono", weight = "Bold" },
})
config.font_size = 12.0
config.harfbuzz_features = { "calt = 0", "clig = 0", "liga = 0" }

return config
