return {
    "vyfor/cord.nvim",
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
    },
}
