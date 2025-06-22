return {
    "shaunsingh/nord.nvim",
    lazy = false,
    config = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = true
        require("nord").set()
    end,
    priority = 1000,
}
