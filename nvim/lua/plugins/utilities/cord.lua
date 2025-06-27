return {
    "vyfor/cord.nvim",
    event = { "VeryLazy" },
    build = ":Cord update",
    opts = {
        editor = {
            tooltip = "Neovim",
        },
        idle = {
            enabled = false,
        },
        text = {
            workspace = "",
        },
        advanced = {
            server = {
                timeout = 30000,
            },
        },
    },
}
