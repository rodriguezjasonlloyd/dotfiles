return {
    "nvim-lualine/lualine.nvim",
    event = { "VeryLazy" },
    opts = {
        options = { theme = "catppuccin" },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { { "filename", path = 4 } },
            lualine_x = {
                { "encoding" },
                { "fileformat" },
                { "filetype", icon_only = true },
            },
            lualine_y = {
                { "progress", separator = "", padding = { left = 1, right = 0 } },
                { "location", padding = { left = 0, right = 1 } },
            },
            lualine_z = {
                function()
                    return os.date("%R")
                end,
            },
        },
    },
}
