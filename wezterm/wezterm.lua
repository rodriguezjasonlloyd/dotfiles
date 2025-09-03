local wezterm = require("wezterm")

local modules = {
    (require("appearance")),
    (require("windows")),
    (require("panes")),
    (require("tabs")),
    (require("performance")),
    (require("keybinds")),
}

local config = wezterm.config_builder()

for _, module in ipairs(modules) do
    for key, value in pairs(module) do
        config[key] = value
    end
end

return config
