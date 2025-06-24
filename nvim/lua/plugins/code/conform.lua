return {
    "stevearc/conform.nvim",
    dependencies = { "mason-org/mason.nvim" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ timeout_ms = 3000 })
            end,
            mode = { "n", "v" },
            desc = "Format Buffer",
            silent = true,
        },
    },
    opts = {
        formatters_by_ft = {
            html = { "prettierd" },
            css = { "prettierd" },
            markdown = { "prettierd" },
            lua = { "stylua" },
            luau = { "stylua" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettierd" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            rust = { "rustfmt" },
            python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        },
        format_on_save = {
            lsp_format = "fallback",
            timeout_ms = 500,
        },
        format_after_save = {
            lsp_format = "fallback",
        },
        default_format_opts = {
            timeout_ms = 3000,
            async = false,
            quiet = false,
            lsp_fallback = true,
        },
    },
}
