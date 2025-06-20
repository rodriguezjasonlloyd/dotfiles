local wezterm = require("wezterm")

local config = {}

config.color_scheme = "nord"
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = 12.0
config.harfbuzz_features = { "calt = 0", "clig = 0", "liga = 0" }

return config
