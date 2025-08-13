return {
    "folke/persistence.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        local persistence = require("persistence")
        persistence.setup()

        if vim.fn.argc() == 0 then
            vim.schedule(persistence.load)
        end
    end,
}
