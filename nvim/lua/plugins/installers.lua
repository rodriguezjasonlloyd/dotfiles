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

        "rust-analyzer",

        "tombi",
    },
})

vim.keymap.set("n", "<leader>m", ":Mason<CR>", { silent = true, desc = "Open Mason" })

require("nvim-treesitter").install({
    "bash",
    "c",
    "diff",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "luap",
    "luau",
    "markdown",
    "markdown_inline",
    "printf",
    "prisma",
    "python",
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
