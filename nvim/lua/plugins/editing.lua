require("blink.cmp").setup({
    fuzzy = { prebuilt_binaries = { force_version = "v1.6.0" } },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
        },
    },
    keymap = { preset = "super-tab" },
})

local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        html = { "prettierd" },
        css = { "prettierd" },
        markdown = { "prettierd" },
        lua = { "stylua" },
        luau = { "stylua" },
        java = { "google-java-format" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        toml = { "tombi" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        rust = { "rustfmt" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    },
    formatters = {
        ["google-java-format"] = {
            prepend_args = { "--aosp" },
        },
    },
    format_on_save = {
        timeout_ms = 10000,
    },
    default_format_opts = {
        timeout_ms = 10000,
        lsp_format = "fallback",
    },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", conform.format, { desc = "Format Buffer", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>cl", function()
    conform.format({ formatters = { "eslint_d" } })
end, { desc = "ESLint Fix", silent = true })

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

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("Lint", { clear = true }),
    callback = function()
        lint.try_lint(nil, { ignore_errors = true })
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        vim.fn.system("eslint_d stop")
    end,
})
