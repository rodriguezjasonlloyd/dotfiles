require("blink.cmp").setup({
    fuzzy = { prebuilt_binaries = { force_version = "v1.6.0" } },
    completion = { documentation = { auto_show = true } },
    keymap = { preset = "super-tab" },
})

local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        html = { "biome" },
        css = { "biome" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        markdown = { "prettierd" },
        json = { "biome" },
        jsonc = { "biome" },
        yaml = { "prettierd" },
        lua = { "stylua" },
        luau = { "stylua" },
        java = { "google-java-format" },
        toml = { "tombi" },
        rust = { "rustfmt" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    },
    formatters = {
        ["google-java-format"] = { prepend_args = { "--aosp" } },
    },
    default_format_opts = {
        timeout_ms = 10000,
        lsp_format = "fallback",
    },
    format_on_save = true,
})

vim.keymap.set({ "n", "v" }, "<leader>cf", conform.format, { desc = "Format Buffer", silent = true })

local lint = require("lint")

lint.linters_by_ft = {
    lua = { "selene" },
    luau = { "selene" },
    javascript = { "biomejs" },
    javascriptreact = { "biomejs" },
    typescript = { "oxlint" },
    typescriptreact = { "oxlint" },
    json = { "biomejs" },
    jsonc = { "biomejs" },
    python = { "ruff" },
}

lint.linters.oxlint.args = vim.list_extend(lint.linters.oxlint.args or {}, { "--type-aware" })

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("Lint", { clear = true }),
    callback = function()
        lint.try_lint()
    end,
})
