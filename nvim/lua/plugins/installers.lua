local mason = require("mason")
mason.setup({})

require("mason-tool-installer").setup({
    ensure_installed = {
        "luau-lsp",
        "lua-language-server",
        "stylua",
        "selene",

        "jdtls",
        "lemminx",
        "google-java-format",

        "pyrefly",
        "ruff",

        "typescript-language-server",
        "superhtml",
        "tailwindcss-language-server",
        "json-lsp",
        "yaml-language-server",
        "prisma-language-server",
        "biome",
        "oxlint",
        "eslint_d",
        "prettierd",

        "rust-analyzer",

        "tombi",
        "qmlls",
        "hyprls",
    },
})

vim.keymap.set("n", "<leader>m", ":Mason<CR>", { silent = true, desc = "Open Mason" })

require("nvim-treesitter").install({
    "bash",
    "c",
    "diff",
    "html",
    "hyprlang",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "latex",
    "lua",
    "luadoc",
    "luap",
    "luau",
    "markdown",
    "markdown_inline",
    "printf",
    "prisma",
    "python",
    "qmljs",
    "query",
    "regex",
    "rust",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
})
