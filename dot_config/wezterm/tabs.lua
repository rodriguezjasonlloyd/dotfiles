local wezterm = require("wezterm")
local utility = require("utility")

local config = {}

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = false

wezterm.on("format-tab-title", function(tab)
    local cwd = tostring(tab.active_pane.current_working_dir):gsub("^file:///?", "")

    if utility.os() == "windows" then
        cwd = cwd:gsub("^[A-Za-z]:", "")
    end

    return cwd
end)

wezterm.on("update-status", function(window)
    window:set_left_status(wezterm.format({
        { Background = { Color = "#b48ead" } },
        { Foreground = { Color = "#eceff4" } },
        { Text = window:leader_is_active() and " ● " or "" },
    }))
end)

return config
