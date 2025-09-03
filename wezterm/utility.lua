local wezterm = require("wezterm")

local utility = {}

function utility.os()
    local target = wezterm.target_triple

    local mapping = {
        ["x86_64-pc-windows-msvc"] = "windows",
        ["x86_64-apple-darwin"] = "macos",
        ["aarch64-apple-darwin"] = "macos",
        ["x86_64-unknown-linux-gnu"] = "linux",
    }

    return mapping[target] or target
end

return utility
