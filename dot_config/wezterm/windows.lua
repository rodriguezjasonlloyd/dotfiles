local wezterm = require("wezterm")

local config = {}

config.initial_cols = 110
config.initial_rows = 36
config.window_decorations = "RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

wezterm.on("gui-startup", function()
    local screen = wezterm.gui.screens().active
    local _, _, window = wezterm.mux.spawn_window({ origin = "ActiveScreen" })
    local gui_window = window:gui_window()
    local dimensions = gui_window:get_dimensions()
    gui_window:set_position((screen.width - dimensions.pixel_width) / 2, (screen.height - dimensions.pixel_height) / 2)
end)

return config
