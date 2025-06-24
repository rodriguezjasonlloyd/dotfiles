return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            lua = { "selene" },
            luau = { "selene" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            python = { "ruff" },
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("Lint", { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
