return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "InsertLeave" },
    opts = {
        events = { "BufEnter", "BufWritePost", "InsertLeave" },
        linters_by_ft = {
            lua = { "selene" },
            luau = { "selene" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
        },
    },
    config = function(_, opts)
        local lint = require("lint")

        lint.linters_by_ft = opts.linters_by_ft

        vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
