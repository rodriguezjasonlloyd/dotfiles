return {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ timeout_ms = 3000 })
            end,
            mode = { "n", "v" },
            desc = "Format Buffer",
        },
    },
    opts = {
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end

            return { timeout_ms = 500, lsp_fallback = true }
        end,

        format_after_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end

            return { lsp_fallback = true }
        end,

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
        },

        formatters = {
            injected = { options = { ignore_errors = true } },
        },

        default_format_opts = {
            timeout_ms = 3000,
            async = false,
            quiet = false,
            lsp_fallback = true,
        },
    },
}
