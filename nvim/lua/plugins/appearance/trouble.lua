return {
    "folke/trouble.nvim",
    event = { "VeryLazy" },
    config = function()
        local trouble = require("trouble")

        vim.diagnostic.config({ severity_sort = true })

        vim.keymap.set("n", "<leader>tt", function()
            vim.diagnostic.open_float({ border = "rounded" })
        end, {
            desc = "Show Diagnostics Float",
            silent = true,
        })

        vim.keymap.set("n", "<leader>td", function()
            trouble.toggle("diagnostics", { mode = { "document" } })
        end, { desc = "Open Diagnostics For Document", silent = true })

        vim.keymap.set("n", "<leader>tw", function()
            trouble.toggle("diagnostics", { mode = { "workspace" } })
        end, { desc = "Open Diagnostics For Workspace", silent = true })
    end,
}
