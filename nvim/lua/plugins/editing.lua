require("blink.cmp").setup({
    fuzzy = { prebuilt_binaries = { force_version = "v1.9.1" } },
    completion = { documentation = { auto_show = true } },
    keymap = { preset = "super-tab" },
})

local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        bash = { "shellharden", "beautysh" },
        css = { "oxfmt" },
        html = { "oxfmt" },
        java = { "google-java-format" },
        javascript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        json = { "oxfmt" },
        json5 = { "oxfmt" },
        jsonc = { "oxfmt" },
        lua = { "stylua" },
        luau = { "stylua" },
        markdown = { "rumdl" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt" },
        scss = { "oxfmt" },
        sh = { "shellharden", "beautysh" },
        toml = { "tombi" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        yaml = { "oxfmt" },
        zsh = { "beautysh" },
    },
    formatters = {
        ["google-java-format"] = { prepend_args = { "--aosp" } },
    },
    default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 10000,
    },
    format_on_save = true,
})

vim.keymap.set({ "n", "v" }, "<leader>cf", conform.format, { desc = "Format Buffer", silent = true })

vim.keymap.set({ "n", "v" }, "<leader>cl", function()
    conform.format({ formatters = { "oxlint" } })
end, { desc = "Fix Lints", silent = true })

local lint = require("lint")

lint.linters_by_ft = {
    javascript = { "oxlint" },
    javascriptreact = { "oxlint" },
    json = { "biomejs" },
    json5 = { "biomejs" },
    jsonc = { "biomejs" },
    lua = { "selene" },
    luau = { "selene" },
    markdown = { "rumdl" },
    python = { "pyrefly", "ruff" },
    typescript = { "oxlint" },
    typescriptreact = { "oxlint" },
}

lint.linters.oxlint.args = vim.list_extend(lint.linters.oxlint.args or {}, { "--type-aware" })

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("Lint", { clear = true }),
    callback = function()
        lint.try_lint()
    end,
})
