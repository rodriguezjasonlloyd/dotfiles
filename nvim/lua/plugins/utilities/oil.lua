return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "VeryLazy" },
    config = function()
        local oil = require("oil")

        oil.setup({
            skip_confirm_for_simple_edits = true,
            constrain_cursor = "name",
            float = {
                padding = 4,
                max_width = 0.6,
            },
        })

        vim.keymap.set("n", "\\", oil.toggle_float, { desc = "Toggle Oil Float", silent = true })
    end,
}
