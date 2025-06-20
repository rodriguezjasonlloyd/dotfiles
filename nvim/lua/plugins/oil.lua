return {
    "stevearc/oil.nvim",
    cond = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {},
    config = function()
        require("oil").setup({
            skip_confirm_for_simple_edits = true,
            constrain_cursor = "name",
            float = {
                padding = 4,
                max_width = 0.6,
            },
        })

        vim.keymap.set("n", "\\", require("oil").toggle_float)
    end,
}
