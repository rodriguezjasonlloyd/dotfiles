return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "shaunsingh/nord.nvim" },
    event = { "VeryLazy" },
    config = function()
        local highlights = require("nord").bufferline.highlights({
            italic = true,
            bold = true,
        })

        require("bufferline").setup({
            options = {
                indicator = { style = "none" },
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diagnostics_dict, _)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " " or (e == "warning" and " " or " ")
                        s = s .. n .. " " .. sym
                    end
                    return s
                end,
            },
            highlights = highlights,
        })
    end,
}
